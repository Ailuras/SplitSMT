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

(declare-sort var1642 0)
(declare-sort var887 0)
(declare-sort var2093 0)
(declare-sort var1200 0)
(declare-sort var2071 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getContextpath/-759878042 (var887) String)
(declare-fun var2093_isEmpty/-813097145 (String) Bool)
(declare-fun var1200_ofNullable/-1077078438 (var2071) var1200)
(declare-fun cast-from-String-to-var2071 (String) var2071)
(declare-const null-var1642 var1642)
(declare-const null-var887 var887)
(declare-const var2993 var1642) ; Statement: r1 := @this: org.apache.dubbo.config.ServiceConfigBase 
(assert (not (= var2993 null-var1642)))
(declare-const var705 var887) ; Statement: r0 := @parameter0: org.apache.dubbo.config.ProtocolConfig 
(assert (not (= var705 null-var887)))
(assert true)
(define-const var848 String (getContextpath/-759878042 var705)) ; Statement: r4 = virtualinvoke r0.<org.apache.dubbo.config.ProtocolConfig: java.lang.String getContextpath()>() 
(define-const var1558 Bool (var2093_isEmpty/-813097145 var848)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4) 
 ; Statement: if $z0 == 0 goto $r5 = staticinvoke <java.util.Optional: java.util.Optional ofNullable(java.lang.Object)>(r4) 
(assert (= (ite var1558 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2251 var1200 (var1200_ofNullable/-1077078438 (cast-from-String-to-var2071 var848))) ; Statement: $r5 = staticinvoke <java.util.Optional: java.util.Optional ofNullable(java.lang.Object)>(r4) 
 ; Statement: return $r5 
(check-sat)
; {getContextpath/-759878042=([org.apache.dubbo.config.ProtocolConfig], java.lang.String), var2093_isEmpty/-813097145=([java.lang.String], boolean), var1200_ofNullable/-1077078438=([java.lang.Object], java.util.Optional), cast-from-String-to-var2071=([java.lang.String], java.lang.Object)}
; {var1642=org.apache.dubbo.config.ServiceConfigBase, var2993=r1, var887=org.apache.dubbo.config.ProtocolConfig, var705=r0, var848=r4, var2093=org.apache.dubbo.common.utils.StringUtils, var1558=$z0, var1200=java.util.Optional, var2071=java.lang.Object, var2251=$r5}
; {org.apache.dubbo.config.ServiceConfigBase=var1642, r1=var2993, org.apache.dubbo.config.ProtocolConfig=var887, r0=var705, r4=var848, org.apache.dubbo.common.utils.StringUtils=var2093, $z0=var1558, java.util.Optional=var1200, java.lang.Object=var2071, $r5=var2251}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.config.ServiceConfigBase;	r0 := @parameter0: org.apache.dubbo.config.ProtocolConfig;	r4 = virtualinvoke r0.<org.apache.dubbo.config.ProtocolConfig: java.lang.String getContextpath()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4);	if $z0 == 0 goto $r5 = staticinvoke <java.util.Optional: java.util.Optional ofNullable(java.lang.Object)>(r4);	$r5 = staticinvoke <java.util.Optional: java.util.Optional ofNullable(java.lang.Object)>(r4);	return $r5
;block_num 2