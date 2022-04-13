let version = "v21.10.2"

module Cluster = struct
  module Elections = Srv_cluster_elections
  module Gossip = Srv_cluster_gossip
end

module Gossip = Srv_gossip
module Monitoring = Srv_monitoring
module Operations = Srv_operations
module PersistentSubscriptions = Srv_persistent_subscriptions
module Projections = Srv_projections
module Streams = Srv_streams
module User = Srv_user
