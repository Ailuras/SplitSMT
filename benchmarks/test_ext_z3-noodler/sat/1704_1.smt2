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

(declare-sort var3124 0)
(declare-sort var1947 0)
(declare-sort var432 0)
(declare-sort var399 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var432_isNotEmpty/-1251449450 (String) Bool)
(declare-fun var399_valueOf/-2107869340 (String) var399)
(declare-const null-var3124 var3124)
(declare-const null-String String)
(declare-const var2112 var3124) ; Statement: r1 := @this: org.apache.dubbo.common.convert.StringToBooleanConverter 
(assert (not (= var2112 null-var3124)))
(declare-const var216 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var216 null-String)))
(define-const var3143 Bool (var432_isNotEmpty/-1251449450 var216)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = null 
(assert (not (= (ite var3143 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2333 var399 (var399_valueOf/-2107869340 var216)) ; Statement: $r2 = staticinvoke <java.lang.Boolean: java.lang.Boolean valueOf(java.lang.String)>(r0) 
 ; Statement: goto [?= return $r2] 
(assert true) ; Non Conditional
 ; Statement: return $r2 
(check-sat)
; {var432_isNotEmpty/-1251449450=([java.lang.String], boolean), var399_valueOf/-2107869340=([java.lang.String], java.lang.Boolean)}
; {var3124=org.apache.dubbo.common.convert.StringToBooleanConverter, var2112=r1, var216=r0, var1947=null_type, var432=org.apache.dubbo.common.utils.StringUtils, var3143=$z0, var399=java.lang.Boolean, var2333=$r2}
; {org.apache.dubbo.common.convert.StringToBooleanConverter=var3124, r1=var2112, r0=var216, null_type=var1947, org.apache.dubbo.common.utils.StringUtils=var432, $z0=var3143, java.lang.Boolean=var399, $r2=var2333}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.convert.StringToBooleanConverter;	r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r2 = null;	$r2 = staticinvoke <java.lang.Boolean: java.lang.Boolean valueOf(java.lang.String)>(r0);	goto [?= return $r2];	return $r2
;block_num 3