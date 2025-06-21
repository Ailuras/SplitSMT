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

(declare-sort var1576 0)
(declare-sort var148 0)
(declare-sort var2612 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun endsWith/985337093 ((s String) (suffix String)) Bool (str.suffixof suffix s))
(declare-fun var2612_isNotEmptyMap/1884409606 (var1576) Bool)
(declare-const null-var1576 var1576)
(declare-const null-String String)
(declare-const var656 var1576) ; Statement: r0 := @parameter0: java.util.Map 
(assert (not (= var656 null-var1576)))
(declare-const var3487 String) ; Statement: r15 := @parameter1: java.lang.String 
(assert (not (= var3487 null-String)))
(declare-const var3160 var1576) ; Statement: r16 := @parameter2: java.util.Map 
(assert (not (= var3160 null-var1576)))
(assert true)
(define-const var770 Bool (endsWith/985337093 var3487 ".")) ; Statement: $z0 = virtualinvoke r15.<java.lang.String: boolean endsWith(java.lang.String)>(".") 
 ; Statement: if $z0 != 0 goto (branch) 
(assert (not (= (ite var770 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: if null != r16 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmptyMap(java.util.Map)>(r0) 
(assert (not (= null-var1576 var3160))) ; Cond: null != r16 
(define-const var1492 Bool (var2612_isNotEmptyMap/1884409606 var656)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmptyMap(java.util.Map)>(r0) 
 ; Statement: if $z1 == 0 goto return r16 
(assert (= (ite var1492 1 0) 0)) ; Cond: $z1 == 0 
 ; Statement: return r16 
(check-sat)
; {endsWith/985337093=([java.lang.String, java.lang.String], boolean), var2612_isNotEmptyMap/1884409606=([java.util.Map], boolean)}
; {var1576=java.util.Map, var656=r0, var3487=r15, var148=null_type, var3160=r16, var770=$z0, var2612=org.apache.dubbo.common.utils.CollectionUtils, var1492=$z1}
; {java.util.Map=var1576, r0=var656, r15=var3487, null_type=var148, r16=var3160, $z0=var770, org.apache.dubbo.common.utils.CollectionUtils=var2612, $z1=var1492}
;seq <java.lang.String: boolean endsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean endsWith(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.util.Map;	r15 := @parameter1: java.lang.String;	r16 := @parameter2: java.util.Map;	$z0 = virtualinvoke r15.<java.lang.String: boolean endsWith(java.lang.String)>(".");	if $z0 != 0 goto (branch);	if null != r16 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmptyMap(java.util.Map)>(r0);	$z1 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmptyMap(java.util.Map)>(r0);	if $z1 == 0 goto return r16;	return r16
;block_num 4