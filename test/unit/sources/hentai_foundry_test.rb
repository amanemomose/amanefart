require 'test_helper'

module Sources
  class HentaiFoundryTest < ActiveSupport::TestCase
    context "A hentai-foundry post" do
      strategy_should_work(
        "https://www.hentai-foundry.com/pictures/user/Afrobull/795025/kuroeda",
        image_urls: ["https://pictures.hentai-foundry.com/a/Afrobull/795025/Afrobull-795025-kuroeda.png"],
        artist_name: "Afrobull",
        artist_commentary_title: "kuroeda",
        profile_url: "https://www.hentai-foundry.com/user/Afrobull",
        media_files: [{ file_size: 1_349_887 }],
        tags: [["elf", "https://www.hentai-foundry.com/pictures/tagged/elf"]]
      )
    end

    context "A hentai-foundry picture" do
      strategy_should_work(
        "https://www.hentai-foundry.com/pictures/user/Afrobull/795025/kuroeda",
        image_urls: ["https://pictures.hentai-foundry.com/a/Afrobull/795025/Afrobull-795025-kuroeda.png"],
        artist_name: "Afrobull",
        artist_commentary_title: "kuroeda",
        profile_url: "https://www.hentai-foundry.com/user/Afrobull",
        media_files: [{ file_size: 1_349_887 }],
        tags: [["elf", "https://www.hentai-foundry.com/pictures/tagged/elf"]]
      )
    end

    context "A deleted picture" do
      strategy_should_work(
        "https://www.hentai-foundry.com/pictures/user/faustsketcher/279498",
        image_urls: [],
        artist_name: "faustsketcher",
        profile_url: "https://www.hentai-foundry.com/user/faustsketcher",
        deleted: true
      )
    end

    context "An old image url" do
      strategy_should_work(
        "http://pictures.hentai-foundry.com//a/AnimeFlux/219123.jpg",
        image_urls: ["https://pictures.hentai-foundry.com/a/AnimeFlux/219123/AnimeFlux-219123-Mobile_Suit_Equestria_rainbow_run.jpg"],
        page_url: "https://www.hentai-foundry.com/pictures/user/AnimeFlux/219123",
        profile_url: "https://www.hentai-foundry.com/user/AnimeFlux"
      )
    end

    context "An image url without the extension" do
      strategy_should_work(
        "http://www.hentai-foundry.com/pictures/user/Ganassa/457176/LOL-Swimsuit---Caitlyn-reworked-nude-ver.",
        image_urls: ["https://pictures.hentai-foundry.com/g/Ganassa/457176/Ganassa-457176-LOL_Swimsuit_-_Caitlyn_reworked_nude_ver..jpg"],
        page_url: "https://www.hentai-foundry.com/pictures/user/Ganassa/457176",
        profile_url: "https://www.hentai-foundry.com/user/Ganassa"
      )
    end

    context "A post with deeply nested commentary" do
      strategy_should_work("https://hentai-foundry.com/pictures/user/LumiNyu/867562/Mona-patreon-winner")
    end

    should "Parse HentaiFoundry URLs correctly" do
      assert(Source::URL.image_url?("https://pictures.hentai-foundry.com/a/Afrobull/795025/Afrobull-795025-kuroeda.png"))
      assert(Source::URL.image_url?("http://pictures.hentai-foundry.com//s/soranamae/363663.jpg"))
      assert(Source::URL.image_url?("http://www.hentai-foundry.com/piccies/d/dmitrys/1183.jpg"))
      assert(Source::URL.image_url?("https://thumbs.hentai-foundry.com/thumb.php?pid=795025&size=350"))

      assert(Source::URL.page_url?("https://www.hentai-foundry.com/pictures/user/Afrobull/795025"))
      assert(Source::URL.page_url?("http://www.hentai-foundry.com/pic-795025"))

      assert(Source::URL.profile_url?("https://www.hentai-foundry.com/user/kajinman"))
      assert(Source::URL.profile_url?("https://www.hentai-foundry.com/pictures/user/kajinman"))
      assert(Source::URL.profile_url?("http://www.hentai-foundry.com/profile-sawao.php"))
    end
  end
end
