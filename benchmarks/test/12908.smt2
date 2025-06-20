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

(declare-sort var3817 0)
(declare-sort var1691 0)
(declare-sort var3579 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceParameter/1782298180 (var3817 String String) String)
(declare-fun var3579_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var3817 var3817)
(declare-const null-String String)
(declare-const var209 var3817) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var209 null-var3817)))
(declare-const var423 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var423 null-String)))
(declare-const var2655 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2655 null-String)))
(assert true)
(define-const var1291 String (getServiceParameter/1782298180 var209 var423 var2655)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var1150 Bool (var3579_isNotEmpty/-1251449450 var1291)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3) 
 ; Statement: return $z0 
(check-sat)
; {getServiceParameter/1782298180=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var3579_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var3817=org.apache.dubbo.common.URL, var209=r0, var423=r1, var1691=null_type, var2655=r2, var1291=r3, var3579=org.apache.dubbo.common.utils.StringUtils, var1150=$z0}
; {org.apache.dubbo.common.URL=var3817, r0=var209, r1=var423, null_type=var1691, r2=var2655, r3=var1291, org.apache.dubbo.common.utils.StringUtils=var3579, $z0=var1150}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3);	return $z0
;block_num 1