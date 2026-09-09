const form = document.querySelector("#search-form");
const query = document.querySelector("#search-query");
const status = document.querySelector("#search-status");
const results = document.querySelector("#search-results");
const more = document.querySelector("#search-more");
const pageSize = 10;
let matches = [];
let shown = 0;
let version = 0;
let timer;

function readURL() {
  const params = new URLSearchParams(location.search);
  query.value = params.get("q") || "";
}

function writeURL() {
  const url = new URL(location.href);
  const term = query.value.trim();
  if (term) url.searchParams.set("q", term);
  else url.searchParams.delete("q");
  // Old shared links may still contain the retired content-type filter.
  url.searchParams.delete("type");
  history.replaceState(null, "", url);
}

function renderResult(data) {
  const item = document.createElement("li");
  const meta = document.createElement("p");
  meta.className = "meta";
  meta.textContent = [data.meta.type, data.meta.date].filter(Boolean).join(" · ");
  const heading = document.createElement("h2");
  const link = document.createElement("a");
  link.href = data.url;
  link.textContent = data.meta.title;
  heading.append(link);
  const excerpt = document.createElement("p");
  // Pagefind escapes the excerpt before adding its <mark> highlights.
  // Other metadata is raw, so it is assigned with textContent above.
  excerpt.innerHTML = data.excerpt;
  item.append(meta, heading, excerpt);
  return item;
}

async function showMore(currentVersion) {
  more.disabled = true;
  try {
    const batch = await Promise.all(matches.slice(shown, shown + pageSize).map(result => result.data()));
    if (currentVersion !== version) return;
    const firstNewIndex = results.children.length;
    results.append(...batch.map(renderResult));
    shown += batch.length;
    more.hidden = shown >= matches.length;
    status.textContent = matches.length
      ? `${matches.length} result${matches.length === 1 ? "" : "s"}. Showing ${shown}.`
      : "No results. Try a different word or phrase.";
    // Keep keyboard users at the newly added results, including the last batch.
    if (firstNewIndex) results.children[firstNewIndex].querySelector("a").focus();
  } finally {
    if (currentVersion === version) more.disabled = false;
  }
}

async function search() {
  clearTimeout(timer);
  const currentVersion = ++version;
  writeURL();
  matches = [];
  shown = 0;
  results.replaceChildren();
  more.hidden = true;
  more.disabled = false;
  const term = query.value.trim();
  if (!term) {
    status.textContent = "Enter a search term to explore the site.";
    return;
  }
  status.textContent = "Searching…";
  try {
    const pagefind = await import("/pagefind/pagefind.js");
    const filters = {};
    // An episode lookup should match its number, not mentions in transcripts.
    const episode = term.match(/^(?:ep|episode)\.?\s*#?\s*(\d+)$/i);
    if (episode) filters.episode = episode[1].replace(/^0+(?=\d)/, "");
    const response = await pagefind.search(episode ? null : term, { filters });
    if (currentVersion !== version) return;
    matches = response.results;
    await showMore(currentVersion);
  } catch (error) {
    if (currentVersion !== version) return;
    status.textContent = "Search could not load. Please try again, or browse using the links above.";
    console.error("Pagefind search failed", error);
  }
}

form.addEventListener("submit", event => {
  event.preventDefault();
  search();
});
query.addEventListener("input", () => {
  // Invalidate an in-flight request immediately, before the debounce expires.
  ++version;
  clearTimeout(timer);
  more.hidden = true;
  timer = setTimeout(search, 200);
});
more.addEventListener("click", async () => {
  const currentVersion = version;
  try {
    await showMore(currentVersion);
  } catch (error) {
    if (currentVersion !== version) return;
    status.textContent = "More results could not load. Please try again.";
    console.error("Pagefind results failed", error);
  }
});
window.addEventListener("popstate", () => {
  readURL();
  search();
});
readURL();
search();
