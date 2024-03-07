/**
 *
 * Defining Interfaces
 *
 */
export interface Variation {

}

export interface Props {
  new?: boolean;
  edit?: boolean;
  readonly?: boolean;
  loading?: boolean;
  variation?: Variation | null;
}
