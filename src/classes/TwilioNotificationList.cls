/*
Copyright (c) 2012 Twilio, Inc.

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
*/
/**
 * The Class NotificationList.
 * 
 * For more information see http://www.twilio.com/docs/api/rest/notification
 */
global class TwilioNotificationList extends TwilioResource.ListResource
	implements Iterable<TwilioNotification> {

	private String parentCallSid;

	/**
	 * Instantiates a new notification list.
	 *
	 * @param client the client
	 */
	public TwilioNotificationList(TwilioRestClient client) {
		super(client);
	}

	/**
	 * Instantiates a new notification list.
	 *
	 * @param client the client
	 * @param filters the filters
	 */
	public TwilioNotificationList(TwilioRestClient client, Map<String, String> filters) {
		super(client, filters);
	}
	
	/**
	 * Instantiates a new notification list under a Call resource.
	 *
	 * @param client the client
	 * @param filters the filters
	 */
	public TwilioNotificationList(TwilioRestClient client, String parentCallSid) {
		super(client);
		this.parentCallSid = parentCallSid;
	}

	/* implements method from TwilioResource */
	public override String getResourceLocation() {
		return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
				+ this.getRequestAccountSid()
				+ (this.parentCallSid!=null ? ('/Calls/'+this.parentCallSid) : '')
				+ '/Notifications.json';
	}

	/* implements method from TwilioResource.ListResource */
	public override Object makeNew(TwilioRestClient client,
			Map<String, Object> params) {
		return new TwilioNotification(client, params);
	}

	/* implements method from TwilioResource.ListResource */
	public override String getListKey() {
		return 'notifications';
	}
	
	/* returns the current response results page */
	public List<TwilioNotification> getPageData() {
		List<TwilioNotification> returnList = new List<TwilioNotification>();
		
		for (Object o : this.getObjectPageData()) {
			if (o instanceof TwilioNotification) {
				returnList.add((TwilioNotification) o);
			}
		}
		return returnList;
	}
	
	/* returns an iterator spanning all data pages */
	global Iterator<TwilioNotification> iterator() {
		return new TwilioIterator.NotificationIterator(this);
	}
}