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

(declare-sort var2580 0)
(declare-sort var683 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceKey/1837900321 (var2580) String)
(declare-fun matchKey/756131061 (var2580) String)
(declare-fun protocol/756131061 (var2580) String)
(declare-fun var683_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var2580 var2580)
(declare-const var1934 var2580) ; Statement: r0 := @this: org.apache.dubbo.metadata.MetadataInfo$ServiceInfo 
(assert (not (= var1934 null-var2580)))
(assert true)
(define-const var3455 String (getServiceKey/1837900321 var1934)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: java.lang.String getServiceKey()>() 
(declare-const var1934!1 var2580)
(assert (not (= var1934!1 null-var2580)))
(assert (= (matchKey/756131061 var1934!1) var3455)) ; Statement: r0.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: java.lang.String matchKey> = $r1 
(define-const var2379 String (protocol/756131061 var1934!1)) ; Statement: $r2 = r0.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: java.lang.String protocol> 
(define-const var1924 Bool (var683_isNotEmpty/-1251449450 var2379)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r2) 
 ; Statement: if $z0 == 0 goto $r3 = r0.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: java.lang.String matchKey> 
(assert (= (ite var1924 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3842 String (matchKey/756131061 var1934!1)) ; Statement: $r3 = r0.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: java.lang.String matchKey> 
 ; Statement: return $r3 
(check-sat)
; {getServiceKey/1837900321=([org.apache.dubbo.metadata.MetadataInfo$ServiceInfo], java.lang.String), matchKey/756131061=([org.apache.dubbo.metadata.MetadataInfo$ServiceInfo], java.lang.String), protocol/756131061=([org.apache.dubbo.metadata.MetadataInfo$ServiceInfo], java.lang.String), var683_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var2580=org.apache.dubbo.metadata.MetadataInfo$ServiceInfo, var1934=r0, var3455=$r1, var2379=$r2, var683=org.apache.dubbo.common.utils.StringUtils, var1924=$z0, var3842=$r3}
; {org.apache.dubbo.metadata.MetadataInfo$ServiceInfo=var2580, r0=var1934, $r1=var3455, $r2=var2379, org.apache.dubbo.common.utils.StringUtils=var683, $z0=var1924, $r3=var3842}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.metadata.MetadataInfo$ServiceInfo;	$r1 = virtualinvoke r0.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: java.lang.String getServiceKey()>();	r0.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: java.lang.String matchKey> = $r1;	$r2 = r0.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: java.lang.String protocol>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r2);	if $z0 == 0 goto $r3 = r0.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: java.lang.String matchKey>;	$r3 = r0.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: java.lang.String matchKey>;	return $r3
;block_num 2