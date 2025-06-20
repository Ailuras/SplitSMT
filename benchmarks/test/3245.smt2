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

(declare-sort var467 0)
(declare-sort var0 0)
(declare-sort var127 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/2046013183 (var467 String) String)
(declare-fun var127_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var467 var467)
(declare-const null-String String)
(declare-const var3832 var467) ; Statement: r0 := @this: org.apache.dubbo.common.URLBuilder 
(assert (not (= var3832 null-var467)))
(declare-const var3177 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3177 null-String)))
(assert true)
(define-const var2934 String (getParameter/2046013183 var3832 var3177)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URLBuilder: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var1812 Bool (var127_isNotEmpty/-1251449450 var2934)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2) 
 ; Statement: return $z0 
(check-sat)
; {getParameter/2046013183=([org.apache.dubbo.common.URLBuilder, java.lang.String], java.lang.String), var127_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var467=org.apache.dubbo.common.URLBuilder, var3832=r0, var3177=r1, var0=null_type, var2934=r2, var127=org.apache.dubbo.common.utils.StringUtils, var1812=$z0}
; {org.apache.dubbo.common.URLBuilder=var467, r0=var3832, r1=var3177, null_type=var0, r2=var2934, org.apache.dubbo.common.utils.StringUtils=var127, $z0=var1812}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URLBuilder;	r1 := @parameter0: java.lang.String;	r2 = virtualinvoke r0.<org.apache.dubbo.common.URLBuilder: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2);	return $z0
;block_num 1