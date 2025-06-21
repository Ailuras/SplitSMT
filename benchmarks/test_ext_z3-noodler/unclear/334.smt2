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

(declare-sort var1292 0)
(declare-sort var3285 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun toCharArray/415275702 (String) (Array Int Int))
(declare-fun getLength-Arr-Int-1 ((Array Int Int)) Int)
(declare-const null-var1292 var1292)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var2191 var1292) ; Statement: r2 := @this: org.antlr.v4.gui.BasicFontMetrics 
(assert (not (= var2191 null-var1292)))
(declare-const var3659 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3659 null-String)))
(declare-const var2806 Int) ; Statement: i2 := @parameter1: int 
(assert (not (= var2806 null-Int)))
(define-const var903 Float64 ((_ to_fp 11 53) #x0000000000000000)) ; Statement: d1 = 0.0 
(assert true)
(define-const var2469 (Array Int Int) (toCharArray/415275702 var3659)) ; Statement: r1 = virtualinvoke r0.<java.lang.String: char[] toCharArray()>() 
(define-const var46 Int (getLength-Arr-Int-1 var2469)) ; Statement: i0 = lengthof r1 
(define-const var1016 Int 0) ; Statement: i3 = 0 
(assert true) ; Non Conditional
 ; Statement: if i3 >= i0 goto return d1 
(assert (>= var1016 var46)) ; Cond: i3 >= i0 
 ; Statement: return d1 
(check-sat)
; {toCharArray/415275702=([java.lang.String], char[]), getLength-Arr-Int-1=([char[]], int)}
; {var1292=org.antlr.v4.gui.BasicFontMetrics, var2191=r2, var3659=r0, var3285=null_type, var2806=i2, var903=d1, var2469=r1, var46=i0, var1016=i3}
; {org.antlr.v4.gui.BasicFontMetrics=var1292, r2=var2191, r0=var3659, null_type=var3285, i2=var2806, d1=var903, r1=var2469, i0=var46, i3=var1016}
;seq <java.lang.String: char[] toCharArray()>
;cnt {"<java.lang.String: char[] toCharArray()>": 1}
;stmts r2 := @this: org.antlr.v4.gui.BasicFontMetrics;	r0 := @parameter0: java.lang.String;	i2 := @parameter1: int;	d1 = 0.0;	r1 = virtualinvoke r0.<java.lang.String: char[] toCharArray()>();	i0 = lengthof r1;	i3 = 0;	if i3 >= i0 goto return d1;	return d1
;block_num 3