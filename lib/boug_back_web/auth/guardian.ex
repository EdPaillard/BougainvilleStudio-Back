defmodule BougBackWeb.Auth.Guardian do
  use Guardian, otp_app: :boug_back
  alias BougBack.Accounts

  @spec subject_for_token(atom | %{:id => any, optional(any) => any}, any) :: {:ok, binary}
  def subject_for_token(%{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :no_id_provided}
  end

  def resource_from_claims(%{"sub" => id}) do
      user = Accounts.get_user!(id)
      {:ok, user}
  rescue
      Ecto.NoResultsError -> {:error, :resource_not_found}
  end

  def resource_from_claims(_claims) do
    {:error, :no_id_provided}
  end

  def authenticate(email, password) do
    case Accounts.get_user_by_email(email) do
      nil ->
        {:error, :unauthorized}
      user ->
        case validate_password(password, user.password) do
          true ->
            if user.role.admin do
              create_token(user, :admin)
            else
              create_token(user, :access)
            end
          false ->
            {:error, :unauthorized}
        end
    end
  end

  def authenticate(token) do
    with {:ok, claims} <- decode_and_verify(token),
         {:ok, user} <- resource_from_claims(claims),
         {:ok, _old, {new_token, _new_claims}} <- refresh(token) do

      {:ok, user, new_token}
    end
  end

  def validate_password(password, hash_password) do
    Argon2.verify_pass(password, hash_password)
  end

  defp create_token(user, type) do
    {:ok, token, _claims} = encode_and_sign(user, %{}, token_option(type))
    {:ok, user, token}
  end

  defp token_option(type) do
    case type do
      :access -> [token_type: "access", ttl: {2, :hour}]
      :admin -> [token_type: "admin", ttl: {1, :day}]
      # :reset -> [token_type: "reset", ttl: {15, :minute}]
    end
  end
end
