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

(declare-sort var1412 0)
(declare-sort var1263 0)
(declare-sort var3182 0)
(declare-sort var3440 0)
(declare-sort var1425 0)
(declare-sort var3474 0)
(declare-sort var1778 0)
(declare-sort var1046 0)
(declare-sort var2591 0)
(declare-sort var2267 0)
(declare-sort var1839 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun zkClient/1812918887 (var1412) var3182)
(declare-fun getNodePath/797673527 (var1412 var3440) String)
(declare-fun cast-from-var1263-to-var3440 (var1263) var3440)
(declare-fun var3182_getContent/-605582539 (var3182 String) String)
(declare-fun var1425_isEmpty/-813097145 (String) Bool)
(declare-fun var3474-init () var3474)
(declare-fun var1778_decode/179454741 (String) String)
(declare-fun var2591_singletonList/684126186 (var2267) var1046)
(declare-fun cast-from-String-to-var2267 (String) var2267)
(declare-fun <init>/2032108350 (var3474 var1839) void)
(declare-fun cast-from-var1046-to-var1839 (var1046) var1839)
(declare-const null-var1412 var1412)
(declare-const null-var1263 var1263)
(declare-const var2785 var1412) ; Statement: r0 := @this: org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport 
(assert (not (= var2785 null-var1412)))
(declare-const var3165 var1263) ; Statement: r1 := @parameter0: org.apache.dubbo.metadata.report.identifier.ServiceMetadataIdentifier 
(assert (not (= var3165 null-var1263)))
(define-const var3940 var3182 (zkClient/1812918887 var2785)) ; Statement: $r2 = r0.<org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport: org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClient zkClient> 
(assert true)
(define-const var2942 String (getNodePath/797673527 var2785 (cast-from-var1263-to-var3440 var3165))) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport: java.lang.String getNodePath(org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier)>(r1) 
(define-const var3081 String (var3182_getContent/-605582539 var3940 var2942)) ; Statement: r4 = interfaceinvoke $r2.<org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClient: java.lang.String getContent(java.lang.String)>($r3) 
(define-const var296 Bool (var1425_isEmpty/-813097145 var3081)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4) 
 ; Statement: if $z0 == 0 goto $r5 = new java.util.ArrayList 
(assert (= (ite var296 1 0) 0)) ; Cond: $z0 == 0 
(define-const var118 var3474 var3474-init) ; Statement: $r5 = new java.util.ArrayList 
(define-const var3307 String (var1778_decode/179454741 var3081)) ; Statement: $r6 = staticinvoke <org.apache.dubbo.common.URL: java.lang.String decode(java.lang.String)>(r4) 
(define-const var3909 var1046 (var2591_singletonList/684126186 (cast-from-String-to-var2267 var3307))) ; Statement: $r7 = staticinvoke <java.util.Collections: java.util.List singletonList(java.lang.Object)>($r6) 
(assert true)
;(assert (<init>/2032108350 var118 (cast-from-var1046-to-var1839 var3909))) ; Statement: specialinvoke $r5.<java.util.ArrayList: void <init>(java.util.Collection)>($r7) 

(declare-const var118!1 var3474)
(declare-const var3909!1 var1046)
 ; Statement: return $r5 
(check-sat)
; {zkClient/1812918887=([org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport], org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClient), getNodePath/797673527=([org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport, org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier], java.lang.String), cast-from-var1263-to-var3440=([org.apache.dubbo.metadata.report.identifier.ServiceMetadataIdentifier], org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier), var3182_getContent/-605582539=([org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClient, java.lang.String], java.lang.String), var1425_isEmpty/-813097145=([java.lang.String], boolean), var3474-init=([], java.util.ArrayList), var1778_decode/179454741=([java.lang.String], java.lang.String), var2591_singletonList/684126186=([java.lang.Object], java.util.List), cast-from-String-to-var2267=([java.lang.String], java.lang.Object), <init>/2032108350=([java.util.ArrayList, java.util.Collection], void), cast-from-var1046-to-var1839=([java.util.List], java.util.Collection)}
; {var1412=org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport, var2785=r0, var1263=org.apache.dubbo.metadata.report.identifier.ServiceMetadataIdentifier, var3165=r1, var3182=org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClient, var3940=$r2, var3440=org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier, var2942=$r3, var3081=r4, var1425=org.apache.dubbo.common.utils.StringUtils, var296=$z0, var3474=java.util.ArrayList, var118=$r5, var1778=org.apache.dubbo.common.URL, var3307=$r6, var1046=java.util.List, var2591=java.util.Collections, var2267=java.lang.Object, var3909=$r7, var1839=java.util.Collection}
; {org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport=var1412, r0=var2785, org.apache.dubbo.metadata.report.identifier.ServiceMetadataIdentifier=var1263, r1=var3165, org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClient=var3182, $r2=var3940, org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier=var3440, $r3=var2942, r4=var3081, org.apache.dubbo.common.utils.StringUtils=var1425, $z0=var296, java.util.ArrayList=var3474, $r5=var118, org.apache.dubbo.common.URL=var1778, $r6=var3307, java.util.List=var1046, java.util.Collections=var2591, java.lang.Object=var2267, $r7=var3909, java.util.Collection=var1839}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport;	r1 := @parameter0: org.apache.dubbo.metadata.report.identifier.ServiceMetadataIdentifier;	$r2 = r0.<org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport: org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClient zkClient>;	$r3 = virtualinvoke r0.<org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport: java.lang.String getNodePath(org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier)>(r1);	r4 = interfaceinvoke $r2.<org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClient: java.lang.String getContent(java.lang.String)>($r3);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4);	if $z0 == 0 goto $r5 = new java.util.ArrayList;	$r5 = new java.util.ArrayList;	$r6 = staticinvoke <org.apache.dubbo.common.URL: java.lang.String decode(java.lang.String)>(r4);	$r7 = staticinvoke <java.util.Collections: java.util.List singletonList(java.lang.Object)>($r6);	specialinvoke $r5.<java.util.ArrayList: void <init>(java.util.Collection)>($r7);	return $r5
;block_num 2