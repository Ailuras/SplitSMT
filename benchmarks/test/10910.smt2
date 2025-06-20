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

(declare-sort var3622 0)
(declare-sort var1883 0)
(declare-sort var668 0)
(declare-sort var380 0)
(declare-sort var482 0)
(declare-sort var2205 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getNodePath/797673527 (var3622 var380) String)
(declare-fun cast-from-var1883-to-var380 (var1883) var380)
(declare-fun zkClient/1812918887 (var3622) var482)
(declare-fun var482_getContent/-605582539 (var482 String) String)
(declare-fun var2205_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var3622 var3622)
(declare-const null-var1883 var1883)
(declare-const null-var668 var668)
(declare-const var2275 var3622) ; Statement: r0 := @this: org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport 
(assert (not (= var2275 null-var3622)))
(declare-const var3110 var1883) ; Statement: r1 := @parameter0: org.apache.dubbo.metadata.report.identifier.SubscriberMetadataIdentifier 
(assert (not (= var3110 null-var1883)))
(declare-const var647 var668) ; Statement: r6 := @parameter1: org.apache.dubbo.metadata.MetadataInfo 
(assert (not (= var647 null-var668)))
(assert true)
(define-const var2150 String (getNodePath/797673527 var2275 (cast-from-var1883-to-var380 var3110))) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport: java.lang.String getNodePath(org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier)>(r1) 
(define-const var646 var482 (zkClient/1812918887 var2275)) ; Statement: $r3 = r0.<org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport: org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClient zkClient> 
(define-const var498 String (var482_getContent/-605582539 var646 var2150)) ; Statement: $r4 = interfaceinvoke $r3.<org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClient: java.lang.String getContent(java.lang.String)>(r2) 
(define-const var1363 Bool (var2205_isNotEmpty/-1251449450 var498)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r4) 
 ; Statement: if $z0 == 0 goto return 
(assert (= (ite var1363 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 
(check-sat)
; {getNodePath/797673527=([org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport, org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier], java.lang.String), cast-from-var1883-to-var380=([org.apache.dubbo.metadata.report.identifier.SubscriberMetadataIdentifier], org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier), zkClient/1812918887=([org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport], org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClient), var482_getContent/-605582539=([org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClient, java.lang.String], java.lang.String), var2205_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var3622=org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport, var2275=r0, var1883=org.apache.dubbo.metadata.report.identifier.SubscriberMetadataIdentifier, var3110=r1, var668=org.apache.dubbo.metadata.MetadataInfo, var647=r6, var380=org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier, var2150=r2, var482=org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClient, var646=$r3, var498=$r4, var2205=org.apache.dubbo.common.utils.StringUtils, var1363=$z0}
; {org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport=var3622, r0=var2275, org.apache.dubbo.metadata.report.identifier.SubscriberMetadataIdentifier=var1883, r1=var3110, org.apache.dubbo.metadata.MetadataInfo=var668, r6=var647, org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier=var380, r2=var2150, org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClient=var482, $r3=var646, $r4=var498, org.apache.dubbo.common.utils.StringUtils=var2205, $z0=var1363}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport;	r1 := @parameter0: org.apache.dubbo.metadata.report.identifier.SubscriberMetadataIdentifier;	r6 := @parameter1: org.apache.dubbo.metadata.MetadataInfo;	r2 = virtualinvoke r0.<org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport: java.lang.String getNodePath(org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier)>(r1);	$r3 = r0.<org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport: org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClient zkClient>;	$r4 = interfaceinvoke $r3.<org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClient: java.lang.String getContent(java.lang.String)>(r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r4);	if $z0 == 0 goto return;	return
;block_num 2