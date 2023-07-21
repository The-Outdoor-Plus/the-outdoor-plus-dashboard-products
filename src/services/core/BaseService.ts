import { Axios, AxiosResponse } from 'axios';
import axios from './http';

export default class BaseService {
  /**
   * @type {string}
   */
  apiVersion = '';

  /**
   * @type {string}; 
   */
  apiResource = '';

  /**
   * Remove double slashes
   * 
   * @param {string} start
   * @param {string} end
   * @return {string}
   */
  static normalize(start: string, end: string) {
    return `${start}/${end}`.replace(/\/{2,}/g, '/');
  }

  /**
   * Implements get method
   * 
   * @param {string} [url='']
   * @param {object} [params={}]
   * 
   * @return {Promise<AxiosResponse>}
   */
  get({ url = '', params = {} } = {}): Promise<AxiosResponse> {
    return axios.get(BaseService.normalize(this.apiVersion, url || this.apiResource), { params });
  }

  /**
   * Implements post method
   * 
   * @param {string} [url='']
   * @param {object} [payload={}]
   * @param {object} [params={}]
   * @param {object} [headers={}]
   * 
   * @return {Promise<AxiosResponse>}
   */
  post({ url = '', payload = {}, params = {}, headers = {}}): Promise<AxiosResponse> {
    return axios.post(BaseService.normalize(this.apiVersion, url || this.apiResource), payload, { params, headers });
  }

  /**
   * Implements put method
   * 
   * @param {string} [url='']
   * @param {object} [payload={}]
   * @param {object} [params={}]
   * 
   * @return {Promise<AxiosResponse>}
   */
  put({ url = '', payload = {}, params = {} }): Promise<AxiosResponse> {
    return axios.put(BaseService.normalize(this.apiVersion, url || this.apiResource), payload, { params });
  }

  /**
   * Implements patch method
   * 
   * @param {string} [url='']
   * @param {object} [payload={}]
   * @param {object} [params={}]
   * 
   * @return {Promise<AxiosResponse>}
   */
  patch({ url = '', payload = {}, params = {} }): Promise<AxiosResponse> {
    return axios.patch(BaseService.normalize(this.apiVersion, url || this.apiResource), payload, { params });
  }

  /**
   * Implements delete method
   * 
   * @param {string} [url='']
   * @param {object} [params={}]
   * 
   * @return {Promise<AxiosResponse>}
   */
  delete({ url = '', params = {} }):Promise<AxiosResponse> {
    return axios.delete(BaseService.normalize(this.apiVersion, url || this.apiResource), { params });
  }

  // -------------------------------
  // Methods for resource management
  // -------------------------------

  /**
   * Alias for get
   * 
   * @param {string} [url='']
   * @param {object} [params={}]
   * 
   * @return {Promise<AxiosResponse>}
   */
  fetch({ url = '', params = {} } = {}): Promise<AxiosResponse> {
    return this.get({ url, params });
  }

  /**
   * Display the specified resource
   * 
   * @param {number} [id]
   * 
   * @return {Promise<AxiosResponse>}
   */
  show(id: number): Promise<AxiosResponse> {
    return this.get({ url: `${this.apiResource}/${id}` });
  }

  /**
   * Store a newly created resource in storage.
   * 
   * @param {object} [payload={}]
   * 
   * @return {Promise<AxiosResponse>}
   */
  store(payload: any): Promise<AxiosResponse> {
    return this.post({ payload });
  }

  /**
   * Update the current resource in storage.
   * 
   * @param {object} [payload={}]
   * 
   * @return {Promise<AxiosResponse>}
   */
  update(payload: any): Promise<AxiosResponse> {
    return this.put({ url: `${this.apiResource}/${payload.id}`, payload });
  }

  /**
   * Remove the specified resource from storage.
   * 
   * @param {number} [id]
   * 
   * @return {Promise<AxiosResponse>}
   */
  destroy(id: number): Promise<AxiosResponse> {
    return this.delete({ url: `${this.apiResource}/${id}` });
  }
}