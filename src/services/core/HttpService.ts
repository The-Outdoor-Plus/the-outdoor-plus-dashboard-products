import { useAuthStore } from '@/store/auth';
import axios from './http';

const auth = useAuthStore();
let _401Interceptor: number;

export default {
  /**
   * Set base URL for any requests
   * 
   * @param {string} domain
   */
  setBaseUrl(domain: string) {
    axios.defaults.baseURL = `${domain}`;
  },
  /**
   * Set Authorization header with Bearer token
   * 
   * @param {string} token
   */
  setAuthorizationHeader(token: string) {
    axios.defaults.headers.common.Authorization = `Bearer ${token}`;
  },
  /**
   * Removes authorization header
   */
  removeAuthorizationHeader() {
    delete axios.defaults.headers.common.Authorization;
  },
  /**
   * Intercept 401 error responses
   */
  mount401Interceptor() {
    _401Interceptor = axios.interceptors.response.use(
      (response) => response,
      (error) => {
        error.response.status === 401 ? auth.logout() : '';
        return Promise.reject(error);
      },
    );
  },
  unmount401Interceptor() {
    axios.interceptors.response.eject(_401Interceptor);
  }
}