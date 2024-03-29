defmodule BougBack.ContentTest do
  use BougBack.DataCase

  alias BougBack.Content

  describe "fragments" do
    alias BougBack.Content.Fragment

    import BougBack.ContentFixtures

    @invalid_attrs %{content: nil, description: nil, miniature: nil, title: nil}

    test "list_fragments/0 returns all fragments" do
      fragment = fragment_fixture()
      assert Content.list_fragments() == [fragment]
    end

    test "get_fragment!/1 returns the fragment with given id" do
      fragment = fragment_fixture()
      assert Content.get_fragment!(fragment.id) == fragment
    end

    test "create_fragment/1 with valid data creates a fragment" do
      valid_attrs = %{content: [], description: "some description", miniature: "some miniature", title: "some title"}

      assert {:ok, %Fragment{} = fragment} = Content.create_fragment(valid_attrs)
      assert fragment.content == []
      assert fragment.description == "some description"
      assert fragment.miniature == "some miniature"
      assert fragment.title == "some title"
    end

    test "create_fragment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_fragment(@invalid_attrs)
    end

    test "update_fragment/2 with valid data updates the fragment" do
      fragment = fragment_fixture()
      update_attrs = %{content: [], description: "some updated description", miniature: "some updated miniature", title: "some updated title"}

      assert {:ok, %Fragment{} = fragment} = Content.update_fragment(fragment, update_attrs)
      assert fragment.content == []
      assert fragment.description == "some updated description"
      assert fragment.miniature == "some updated miniature"
      assert fragment.title == "some updated title"
    end

    test "update_fragment/2 with invalid data returns error changeset" do
      fragment = fragment_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_fragment(fragment, @invalid_attrs)
      assert fragment == Content.get_fragment!(fragment.id)
    end

    test "delete_fragment/1 deletes the fragment" do
      fragment = fragment_fixture()
      assert {:ok, %Fragment{}} = Content.delete_fragment(fragment)
      assert_raise Ecto.NoResultsError, fn -> Content.get_fragment!(fragment.id) end
    end

    test "change_fragment/1 returns a fragment changeset" do
      fragment = fragment_fixture()
      assert %Ecto.Changeset{} = Content.change_fragment(fragment)
    end
  end

  describe "heroes" do
    alias BougBack.Content.Heroe

    import BougBack.ContentFixtures

    @invalid_attrs %{background: nil, options: nil, pnj_picture: nil, pnj_sentence: nil, save_scene: nil}

    test "list_heroes/0 returns all heroes" do
      heroe = heroe_fixture()
      assert Content.list_heroes() == [heroe]
    end

    test "get_heroe!/1 returns the heroe with given id" do
      heroe = heroe_fixture()
      assert Content.get_heroe!(heroe.id) == heroe
    end

    test "create_heroe/1 with valid data creates a heroe" do
      valid_attrs = %{background: "some background", options: "some options", pnj_picture: "some pnj_picture", pnj_sentence: "some pnj_sentence", save_scene: 42}

      assert {:ok, %Heroe{} = heroe} = Content.create_heroe(valid_attrs)
      assert heroe.background == "some background"
      assert heroe.options == "some options"
      assert heroe.pnj_picture == "some pnj_picture"
      assert heroe.pnj_sentence == "some pnj_sentence"
      assert heroe.save_scene == 42
    end

    test "create_heroe/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_heroe(@invalid_attrs)
    end

    test "update_heroe/2 with valid data updates the heroe" do
      heroe = heroe_fixture()
      update_attrs = %{background: "some updated background", options: "some updated options", pnj_picture: "some updated pnj_picture", pnj_sentence: "some updated pnj_sentence", save_scene: 43}

      assert {:ok, %Heroe{} = heroe} = Content.update_heroe(heroe, update_attrs)
      assert heroe.background == "some updated background"
      assert heroe.options == "some updated options"
      assert heroe.pnj_picture == "some updated pnj_picture"
      assert heroe.pnj_sentence == "some updated pnj_sentence"
      assert heroe.save_scene == 43
    end

    test "update_heroe/2 with invalid data returns error changeset" do
      heroe = heroe_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_heroe(heroe, @invalid_attrs)
      assert heroe == Content.get_heroe!(heroe.id)
    end

    test "delete_heroe/1 deletes the heroe" do
      heroe = heroe_fixture()
      assert {:ok, %Heroe{}} = Content.delete_heroe(heroe)
      assert_raise Ecto.NoResultsError, fn -> Content.get_heroe!(heroe.id) end
    end

    test "change_heroe/1 returns a heroe changeset" do
      heroe = heroe_fixture()
      assert %Ecto.Changeset{} = Content.change_heroe(heroe)
    end
  end

  describe "timelines" do
    alias BougBack.Content.Timeline

    import BougBack.ContentFixtures

    @invalid_attrs %{content: nil, title: nil}

    test "list_timelines/0 returns all timelines" do
      timeline = timeline_fixture()
      assert Content.list_timelines() == [timeline]
    end

    test "get_timeline!/1 returns the timeline with given id" do
      timeline = timeline_fixture()
      assert Content.get_timeline!(timeline.id) == timeline
    end

    test "create_timeline/1 with valid data creates a timeline" do
      valid_attrs = %{content: [], title: "some title"}

      assert {:ok, %Timeline{} = timeline} = Content.create_timeline(valid_attrs)
      assert timeline.content == []
      assert timeline.title == "some title"
    end

    test "create_timeline/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_timeline(@invalid_attrs)
    end

    test "update_timeline/2 with valid data updates the timeline" do
      timeline = timeline_fixture()
      update_attrs = %{content: [], title: "some updated title"}

      assert {:ok, %Timeline{} = timeline} = Content.update_timeline(timeline, update_attrs)
      assert timeline.content == []
      assert timeline.title == "some updated title"
    end

    test "update_timeline/2 with invalid data returns error changeset" do
      timeline = timeline_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_timeline(timeline, @invalid_attrs)
      assert timeline == Content.get_timeline!(timeline.id)
    end

    test "delete_timeline/1 deletes the timeline" do
      timeline = timeline_fixture()
      assert {:ok, %Timeline{}} = Content.delete_timeline(timeline)
      assert_raise Ecto.NoResultsError, fn -> Content.get_timeline!(timeline.id) end
    end

    test "change_timeline/1 returns a timeline changeset" do
      timeline = timeline_fixture()
      assert %Ecto.Changeset{} = Content.change_timeline(timeline)
    end
  end

  describe "contents" do
    alias BougBack.Content.Contents

    import BougBack.ContentFixtures

    @invalid_attrs %{body: nil}

    test "list_contents/0 returns all contents" do
      contents = contents_fixture()
      assert Content.list_contents() == [contents]
    end

    test "get_contents!/1 returns the contents with given id" do
      contents = contents_fixture()
      assert Content.get_contents!(contents.id) == contents
    end

    test "create_contents/1 with valid data creates a contents" do
      valid_attrs = %{body: "some body"}

      assert {:ok, %Contents{} = contents} = Content.create_contents(valid_attrs)
      assert contents.body == "some body"
    end

    test "create_contents/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_contents(@invalid_attrs)
    end

    test "update_contents/2 with valid data updates the contents" do
      contents = contents_fixture()
      update_attrs = %{body: "some updated body"}

      assert {:ok, %Contents{} = contents} = Content.update_contents(contents, update_attrs)
      assert contents.body == "some updated body"
    end

    test "update_contents/2 with invalid data returns error changeset" do
      contents = contents_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_contents(contents, @invalid_attrs)
      assert contents == Content.get_contents!(contents.id)
    end

    test "delete_contents/1 deletes the contents" do
      contents = contents_fixture()
      assert {:ok, %Contents{}} = Content.delete_contents(contents)
      assert_raise Ecto.NoResultsError, fn -> Content.get_contents!(contents.id) end
    end

    test "change_contents/1 returns a contents changeset" do
      contents = contents_fixture()
      assert %Ecto.Changeset{} = Content.change_contents(contents)
    end
  end

  describe "miniaturess" do
    alias BougBack.Content.Miniature

    import BougBack.ContentFixtures

    @invalid_attrs %{mini: nil}

    test "list_miniaturess/0 returns all miniaturess" do
      miniature = miniature_fixture()
      assert Content.list_miniaturess() == [miniature]
    end

    test "get_miniature!/1 returns the miniature with given id" do
      miniature = miniature_fixture()
      assert Content.get_miniature!(miniature.id) == miniature
    end

    test "create_miniature/1 with valid data creates a miniature" do
      valid_attrs = %{mini: "some mini"}

      assert {:ok, %Miniature{} = miniature} = Content.create_miniature(valid_attrs)
      assert miniature.mini == "some mini"
    end

    test "create_miniature/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_miniature(@invalid_attrs)
    end

    test "update_miniature/2 with valid data updates the miniature" do
      miniature = miniature_fixture()
      update_attrs = %{mini: "some updated mini"}

      assert {:ok, %Miniature{} = miniature} = Content.update_miniature(miniature, update_attrs)
      assert miniature.mini == "some updated mini"
    end

    test "update_miniature/2 with invalid data returns error changeset" do
      miniature = miniature_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_miniature(miniature, @invalid_attrs)
      assert miniature == Content.get_miniature!(miniature.id)
    end

    test "delete_miniature/1 deletes the miniature" do
      miniature = miniature_fixture()
      assert {:ok, %Miniature{}} = Content.delete_miniature(miniature)
      assert_raise Ecto.NoResultsError, fn -> Content.get_miniature!(miniature.id) end
    end

    test "change_miniature/1 returns a miniature changeset" do
      miniature = miniature_fixture()
      assert %Ecto.Changeset{} = Content.change_miniature(miniature)
    end
  end
end
