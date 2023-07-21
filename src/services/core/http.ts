import axios from 'axios';

axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded';
axios.defaults.headers.post.Accept = 'application/json';
axios.defaults.headers.put['Content-Type'] = 'application/x-www-form-urlencoded';

export default axios;