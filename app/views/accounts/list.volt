{% extends 'layouts/default.volt' %}

{% block header %}

{% endblock %}

{% block content %}
<div class="ui vertical stripe segment">
  <div class="ui middle aligned stackable grid container">
    <div class="row">
      <div class="column">
        <div class="ui top attached menu">
          <div class="ui dropdown item">
            Richlist
            <i class="dropdown icon"></i>
            <div class="menu">
              <a class="{{ filter == 'vest' ? 'active' : '' }} item" href="/accounts/vest">
                Vests/SP
              </a>
              <a class="{{ filter == 'sbd' ? 'active' : '' }} item" href="/accounts/sbd">
                SBD
              </a>
              <a class="{{ filter == 'steem' ? 'active' : '' }} item" href="/accounts/steem">
                STEEM
              </a>
            </div>
          </div>
          <a class="{{ filter == 'posts' ? 'active' : '' }} item" href="/accounts/posts">
            Posts
          </a>
          <div class="ui dropdown item">
            Social
            <i class="dropdown icon"></i>
            <div class="menu">
              <a class="{{ filter == 'followers' ? 'active' : '' }} item" href="/accounts/followers">
                Followers
              </a>
              <a class="{{ filter == 'followers_mvest' ? 'active' : '' }} item" href="/accounts/followers_mvest">
                Value of Followers
              </a>
            </div>
          </div>
          <a class="{{ filter == 'reputation' ? 'active' : '' }} item" href="/accounts/reputation">
            Reputation
          </a>
          <div class="right menu">
            <div class="item">
              Data updated <?php echo $this->timeAgo::mongo($accounts[0]->scanned); ?>
            </div>
          </div>
        </div>
        <table class="ui attached table">
          <thead>
            <tr>
              <th>Account</th>
              <th class="center aligned">Followers</th>
              <th class="center aligned">Posts</th>
              <th class="right aligned">Vests</th>
              <th class="right aligned">Balances</th>
            </tr>
          </thead>
          <tbody>
            {% for account in accounts %}
            <tr>
              <td>
                <div class="ui header">
                  <div class="ui circular blue label">
                    <?php echo $this->reputation::number($account->reputation) ?>
                  </div>
                  {{ link_to("/@" ~ account.name, account.name) }}
                </div>
              </td>
              <td class="collapsing center aligned">
                <div class="ui small header">
                  {{ account.followers_count }}
                  <div class="sub header">
                    <?php echo $this->largeNumber::format($account->followers_mvest); ?>
                  </div>
                </div>
              </td>
              <td class="collapsing center aligned">
                {{ account.post_count }}
              </td>
              <td class="collapsing right aligned">
                {{ partial("_elements/vesting_shares", ['current': account]) }}
              </td>
              <td class="collapsing right aligned">
                <div class="ui small header">
                  <?php echo number_format($account->total_sbd_balance, 3, ".", ",") ?> SBD
                  <div class="sub header">
                    <?php echo number_format($account->total_balance, 3, ".", ",") ?> STEEM
                  </div>
                </div>
              </td>
            </tr>
            {% endfor %}
          </tbody>
        </table>
        {% include "_elements/paginator.volt" %}
      </div>
    </div>
  </div>
</div>
{% endblock %}
