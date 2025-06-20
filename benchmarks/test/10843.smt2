(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var3495 0)
(declare-sort var3903 0)
(declare-sort var3959 0)
(declare-sort var3562 0)
(declare-sort var2303 0)
(declare-sort var3770 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getNodePath/797673527 (var3495 var3562) String)
(declare-fun cast-from-var3903-to-var3562 (var3903) var3562)
(declare-fun zkClient/1812918887 (var3495) var2303)
(declare-fun var2303_getContent/-605582539 (var2303 String) String)
(declare-fun var3770_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var3495 var3495)
(declare-const null-var3903 var3903)
(declare-const null-var3959 var3959)
(declare-const var1280 var3495) ; Statement: r0 := @this: org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport 
(assert (not (= var1280 null-var3495)))
(declare-const var3870 var3903) ; Statement: r1 := @parameter0: org.apache.dubbo.metadata.report.identifier.SubscriberMetadataIdentifier 
(assert (not (= var3870 null-var3903)))
(declare-const var3821 var3959) ; Statement: r5 := @parameter1: org.apache.dubbo.metadata.MetadataInfo 
(assert (not (= var3821 null-var3959)))
(assert true)
(define-const var2427 String (getNodePath/797673527 var1280 (cast-from-var3903-to-var3562 var3870))) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport: java.lang.String getNodePath(org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier)>(r1) 
(define-const var122 var2303 (zkClient/1812918887 var1280)) ; Statement: $r3 = r0.<org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport: org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClient zkClient> 
(define-const var3739 String (var2303_getContent/-605582539 var122 var2427)) ; Statement: $r4 = interfaceinvoke $r3.<org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClient: java.lang.String getContent(java.lang.String)>(r2) 
(define-const var661 Bool (var3770_isBlank/-523695098 (cast-from-String-to-String var3739))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>($r4) 
 ; Statement: if $z0 == 0 goto return 
(assert (= (ite var661 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 
(check-sat)
; {getNodePath/797673527=([org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport, org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier], java.lang.String), cast-from-var3903-to-var3562=([org.apache.dubbo.metadata.report.identifier.SubscriberMetadataIdentifier], org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier), zkClient/1812918887=([org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport], org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClient), var2303_getContent/-605582539=([org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClient, java.lang.String], java.lang.String), var3770_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var3495=org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport, var1280=r0, var3903=org.apache.dubbo.metadata.report.identifier.SubscriberMetadataIdentifier, var3870=r1, var3959=org.apache.dubbo.metadata.MetadataInfo, var3821=r5, var3562=org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier, var2427=r2, var2303=org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClient, var122=$r3, var3739=$r4, var3770=org.apache.dubbo.common.utils.StringUtils, var661=$z0}
; {org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport=var3495, r0=var1280, org.apache.dubbo.metadata.report.identifier.SubscriberMetadataIdentifier=var3903, r1=var3870, org.apache.dubbo.metadata.MetadataInfo=var3959, r5=var3821, org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier=var3562, r2=var2427, org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClient=var2303, $r3=var122, $r4=var3739, org.apache.dubbo.common.utils.StringUtils=var3770, $z0=var661}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r0 := @this: org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport;	r1 := @parameter0: org.apache.dubbo.metadata.report.identifier.SubscriberMetadataIdentifier;	r5 := @parameter1: org.apache.dubbo.metadata.MetadataInfo;	r2 = virtualinvoke r0.<org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport: java.lang.String getNodePath(org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier)>(r1);	$r3 = r0.<org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport: org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClient zkClient>;	$r4 = interfaceinvoke $r3.<org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClient: java.lang.String getContent(java.lang.String)>(r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>($r4);	if $z0 == 0 goto return;	return
;block_num 2