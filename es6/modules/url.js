import $ from 'jquery';

const appHost = $('meta[name="appHost"]')[0].content;
const url = (route) => `${appHost}${route}`;

export default url;
