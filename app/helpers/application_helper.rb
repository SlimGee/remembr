module ApplicationHelper
  def canonical(url)
    content_for(:canonical, tag(:link, rel: :canonical, href: url)) if url
  end

  def default_meta_tags
    {
      site: "Remembr",
      title: "Search over 1000 funeral notices and obituaries",
      reverse: true,
      separator: "|",
      description: "Find and share funeral notices in Zimbabwe. Honor loved ones with simple, respectful memorials. Stay updated on recent passings",
      keywords: "funeral notices, obituary, obituaries, Zimbabwe obituaries, memorials, death notices, funeral services, funeral arrangements, online tributes, condolences, tribute messages, funeral home, cemetery, burial services, grief support, last respects, in memory, eulogy, online memorials, memorial website, life celebration, sympathy messages, Zimbabwe funerals, passing announcement, remembrance, tribute page, family tree, deceased, final arrangements, funeral planning, death announcement, online obituary, legacy, memorial service, death notice, paying respects, digital memorial, loved ones, remembrance services, funeral directory, obituary search, Zimbabwe death notices, bereavement, funeral invitation, digital obituary, memorial fund, charity donation, funeral program, obituary writing, in loving memory, funeral announcement, memorial tribute, funeral details, last farewell, funeral notice, obituary template, funeral info, death records, Zimbabwe obituary website, funeral registry, funeral customs, online condolence, funeral planner",
      og: {
        site_name: "Remembr",
        title: "Search over 1000 funeral notices and obituaries",
        description: "Find and share funeral notices in Zimbabwe. Honor loved ones with simple, respectful memorials. Stay updated on recent passings",
        type: "website",
        url: request.original_url,
        image: image_url("cover.jpg")
      },
      twitter: {
        card: "summary_large_image",
        site: "@remembrzw",
        title: "Search over 1000 funeral notices and obituaries",
        description: "Find and share funeral notices in Zimbabwe. Honor loved ones with simple, respectful memorials. Stay updated on recent passings",
        image: image_url("cover.jpg")
      }
    }
  end
end
