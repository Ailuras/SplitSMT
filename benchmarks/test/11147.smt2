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

(declare-sort var1568 0)
(declare-sort var839 0)
(declare-sort var1097 0)
(declare-sort var1062 0)
(declare-sort var3484 0)
(declare-sort var3417 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getConfig/-1278229556 (var1568 var1097) String)
(declare-fun cast-from-var839-to-var1097 (var839) var1097)
(declare-fun var1062_isEmpty/-813097145 (String) Bool)
(declare-fun var3417_emptyList/582664469 () var3484)
(declare-const null-var1568 var1568)
(declare-const null-var839 var839)
(declare-const var828 var1568) ; Statement: r0 := @this: org.apache.dubbo.metadata.store.nacos.NacosMetadataReport 
(assert (not (= var828 null-var1568)))
(declare-const var2380 var839) ; Statement: r1 := @parameter0: org.apache.dubbo.metadata.report.identifier.ServiceMetadataIdentifier 
(assert (not (= var2380 null-var839)))
(assert true)
(define-const var2014 String (getConfig/-1278229556 var828 (cast-from-var839-to-var1097 var2380))) ; Statement: r2 = specialinvoke r0.<org.apache.dubbo.metadata.store.nacos.NacosMetadataReport: java.lang.String getConfig(org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier)>(r1) 
(define-const var1938 Bool (var1062_isEmpty/-813097145 var2014)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $r3 = new java.util.ArrayList 
(assert (not (= (ite var1938 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2564 var3484 var3417_emptyList/582664469) ; Statement: $r7 = staticinvoke <java.util.Collections: java.util.List emptyList()>() 
 ; Statement: return $r7 
(check-sat)
; {getConfig/-1278229556=([org.apache.dubbo.metadata.store.nacos.NacosMetadataReport, org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier], java.lang.String), cast-from-var839-to-var1097=([org.apache.dubbo.metadata.report.identifier.ServiceMetadataIdentifier], org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier), var1062_isEmpty/-813097145=([java.lang.String], boolean), var3417_emptyList/582664469=([], java.util.List)}
; {var1568=org.apache.dubbo.metadata.store.nacos.NacosMetadataReport, var828=r0, var839=org.apache.dubbo.metadata.report.identifier.ServiceMetadataIdentifier, var2380=r1, var1097=org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier, var2014=r2, var1062=org.apache.dubbo.common.utils.StringUtils, var1938=$z0, var3484=java.util.List, var3417=java.util.Collections, var2564=$r7}
; {org.apache.dubbo.metadata.store.nacos.NacosMetadataReport=var1568, r0=var828, org.apache.dubbo.metadata.report.identifier.ServiceMetadataIdentifier=var839, r1=var2380, org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier=var1097, r2=var2014, org.apache.dubbo.common.utils.StringUtils=var1062, $z0=var1938, java.util.List=var3484, java.util.Collections=var3417, $r7=var2564}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.metadata.store.nacos.NacosMetadataReport;	r1 := @parameter0: org.apache.dubbo.metadata.report.identifier.ServiceMetadataIdentifier;	r2 = specialinvoke r0.<org.apache.dubbo.metadata.store.nacos.NacosMetadataReport: java.lang.String getConfig(org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $r3 = new java.util.ArrayList;	$r7 = staticinvoke <java.util.Collections: java.util.List emptyList()>();	return $r7
;block_num 2