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

(declare-sort var2071 0)
(declare-sort var445 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var445_hasText/2115555376 (String) Bool)
(declare-const null-String String)
(declare-const var431 String) ; Statement: r0 := @parameter0: java.lang.StringBuilder 
(assert (not (= var431 null-String)))
(declare-const var1946 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var1946 null-String)))
(assert true)
;(assert (append/672562846 var431 ":")) ; Statement: virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(":") 
(declare-const var431!1 String)
(assert (= var431!1 (str.++ var431 ":")))
(define-const var1065 Bool (var445_hasText/2115555376 var1946)) ; Statement: $z0 = staticinvoke <org.springframework.util.StringUtils: boolean hasText(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto return 
(assert (= (ite var1065 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 
(check-sat)
; {append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var445_hasText/2115555376=([java.lang.String], boolean)}
; {var431=r0, var1946=r1, var2071=null_type, var445=org.springframework.util.StringUtils, var1065=$z0}
; {r0=var431, r1=var1946, null_type=var2071, org.springframework.util.StringUtils=var445, $z0=var1065}
;seq <java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<org.springframework.util.StringUtils: boolean hasText(java.lang.String)>
;cnt {"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<org.springframework.util.StringUtils: boolean hasText(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.StringBuilder;	r1 := @parameter1: java.lang.String;	virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(":");	$z0 = staticinvoke <org.springframework.util.StringUtils: boolean hasText(java.lang.String)>(r1);	if $z0 == 0 goto return;	return
;block_num 2