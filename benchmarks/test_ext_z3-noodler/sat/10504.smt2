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

(declare-sort var2799 0)
(declare-sort var3036 0)
(declare-sort var153 0)
(declare-sort var316 0)
(declare-sort var847 0)
(declare-sort var3575 0)
(declare-sort var2676 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun zkClient/1812918887 (var2799) var153)
(declare-fun getNodePath/797673527 (var2799 var316) String)
(declare-fun cast-from-var3036-to-var316 (var3036) var316)
(declare-fun var153_getContent/-605582539 (var153 String) String)
(declare-fun var847_isEmpty/-813097145 (String) Bool)
(declare-fun var2676_emptyList/582664469 () var3575)
(declare-const null-var2799 var2799)
(declare-const null-var3036 var3036)
(declare-const var821 var2799) ; Statement: r0 := @this: org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport 
(assert (not (= var821 null-var2799)))
(declare-const var2068 var3036) ; Statement: r1 := @parameter0: org.apache.dubbo.metadata.report.identifier.ServiceMetadataIdentifier 
(assert (not (= var2068 null-var3036)))
(define-const var701 var153 (zkClient/1812918887 var821)) ; Statement: $r2 = r0.<org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport: org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClient zkClient> 
(assert true)
(define-const var1764 String (getNodePath/797673527 var821 (cast-from-var3036-to-var316 var2068))) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport: java.lang.String getNodePath(org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier)>(r1) 
(define-const var3576 String (var153_getContent/-605582539 var701 var1764)) ; Statement: r4 = interfaceinvoke $r2.<org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClient: java.lang.String getContent(java.lang.String)>($r3) 
(define-const var3997 Bool (var847_isEmpty/-813097145 var3576)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4) 
 ; Statement: if $z0 == 0 goto $r5 = new java.util.ArrayList 
(assert (not (= (ite var3997 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3697 var3575 var2676_emptyList/582664469) ; Statement: $r8 = staticinvoke <java.util.Collections: java.util.List emptyList()>() 
 ; Statement: return $r8 
(check-sat)
; {zkClient/1812918887=([org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport], org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClient), getNodePath/797673527=([org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport, org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier], java.lang.String), cast-from-var3036-to-var316=([org.apache.dubbo.metadata.report.identifier.ServiceMetadataIdentifier], org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier), var153_getContent/-605582539=([org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClient, java.lang.String], java.lang.String), var847_isEmpty/-813097145=([java.lang.String], boolean), var2676_emptyList/582664469=([], java.util.List)}
; {var2799=org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport, var821=r0, var3036=org.apache.dubbo.metadata.report.identifier.ServiceMetadataIdentifier, var2068=r1, var153=org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClient, var701=$r2, var316=org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier, var1764=$r3, var3576=r4, var847=org.apache.dubbo.common.utils.StringUtils, var3997=$z0, var3575=java.util.List, var2676=java.util.Collections, var3697=$r8}
; {org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport=var2799, r0=var821, org.apache.dubbo.metadata.report.identifier.ServiceMetadataIdentifier=var3036, r1=var2068, org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClient=var153, $r2=var701, org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier=var316, $r3=var1764, r4=var3576, org.apache.dubbo.common.utils.StringUtils=var847, $z0=var3997, java.util.List=var3575, java.util.Collections=var2676, $r8=var3697}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport;	r1 := @parameter0: org.apache.dubbo.metadata.report.identifier.ServiceMetadataIdentifier;	$r2 = r0.<org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport: org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClient zkClient>;	$r3 = virtualinvoke r0.<org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport: java.lang.String getNodePath(org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier)>(r1);	r4 = interfaceinvoke $r2.<org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClient: java.lang.String getContent(java.lang.String)>($r3);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4);	if $z0 == 0 goto $r5 = new java.util.ArrayList;	$r8 = staticinvoke <java.util.Collections: java.util.List emptyList()>();	return $r8
;block_num 2