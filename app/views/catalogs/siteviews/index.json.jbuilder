json.array!(@catalogs_siteviews) do |catalogs_siteview|
  json.extract! catalogs_siteview, :id, :contract_id, :visit_date, :completed
  json.url catalogs_siteview_url(catalogs_siteview, format: :json)
end
