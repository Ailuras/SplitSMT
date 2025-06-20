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

(declare-sort var2263 0)
(declare-sort var3322 0)
(declare-sort var1342 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1342_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var2263 var2263)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var353 var2263) ; Statement: r1 := @this: org.apache.dubbo.common.convert.StringToByteConverter 
(assert (not (= var353 null-var2263)))
(declare-const var145 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var145 null-String)))
(define-const var2457 Bool (var1342_isNotEmpty/-1251449450 var145)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = null 
(assert (= (ite var2457 1 0) 0)) ; Cond: $z0 == 0 
(define-const var946 Int null-Int) ; Statement: $r2 = null 
(assert true) ; Non Conditional
 ; Statement: return $r2 
(check-sat)
; {var1342_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var2263=org.apache.dubbo.common.convert.StringToByteConverter, var353=r1, var145=r0, var3322=null_type, var1342=org.apache.dubbo.common.utils.StringUtils, var2457=$z0, var946=$r2}
; {org.apache.dubbo.common.convert.StringToByteConverter=var2263, r1=var353, r0=var145, null_type=var3322, org.apache.dubbo.common.utils.StringUtils=var1342, $z0=var2457, $r2=var946}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.convert.StringToByteConverter;	r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r2 = null;	$r2 = null;	return $r2
;block_num 3