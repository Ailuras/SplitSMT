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

(declare-sort var1556 0)
(declare-sort var3886 0)
(declare-sort var1115 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1115_isEmpty/-813097145 (String) Bool)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const null-var3886 var3886)
(declare-const var39 String) ; Statement: r5 := @parameter0: java.lang.String 
(assert (not (= var39 null-String)))
(declare-const var3030 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var3030 null-String)))
(declare-const var1200 Int) ; Statement: i0 := @parameter2: int 
(assert (not (= var1200 null-Int)))
(declare-const var2211 var3886) ; Statement: r1 := @parameter3: java.util.regex.Pattern 
(assert (not (= var2211 null-var3886)))
(define-const var1471 Bool (var1115_isEmpty/-813097145 var3030)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $i1 = virtualinvoke r0.<java.lang.String: int length()>() 
(assert (not (= (ite var1471 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return 
(check-sat)
; {var1115_isEmpty/-813097145=([java.lang.String], boolean)}
; {var39=r5, var1556=null_type, var3030=r0, var1200=i0, var3886=java.util.regex.Pattern, var2211=r1, var1115=org.apache.dubbo.common.utils.StringUtils, var1471=$z0}
; {r5=var39, null_type=var1556, r0=var3030, i0=var1200, java.util.regex.Pattern=var3886, r1=var2211, org.apache.dubbo.common.utils.StringUtils=var1115, $z0=var1471}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r5 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String;	i0 := @parameter2: int;	r1 := @parameter3: java.util.regex.Pattern;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $i1 = virtualinvoke r0.<java.lang.String: int length()>();	return
;block_num 2