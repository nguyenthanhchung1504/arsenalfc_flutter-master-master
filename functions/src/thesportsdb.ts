import { TSDB_API_BASE } from './config';

/** Gọi GET TheSportsDB. */
export async function tsdbGet<T = unknown>(
  path: string,
  query: Record<string, string | number> = {},
): Promise<T> {
  const url = new URL(`${TSDB_API_BASE}${path}`);
  Object.entries(query).forEach(([k, v]) => url.searchParams.set(k, String(v)));

  const res = await fetch(url.toString());
  if (!res.ok) {
    const body = await res.text();
    throw new Error(`TheSportsDB ${res.status}: ${body}`);
  }
  return (await res.json()) as T;
}
