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

(declare-sort var1983 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-String String)
(declare-const var1119 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1119 null-String)))
(define-const var1438 String "\n\t\t\n\t\t\n\ue000\ue001\ue002\n\t\t\t\t\n") ; Statement: $r1 = "\n\t\t\n\t\t\n\ue000\ue001\ue002\n\t\t\t\t\n" 
(assert true)
(define-const var2617 Bool (= var1438 var1119)) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = r0 
(assert (= (ite var2617 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1621 String var1119) ; Statement: $r2 = r0 
(assert true) ; Non Conditional
 ; Statement: return $r2 
(check-sat)
; {}
; {var1119=r0, var1983=null_type, var1438=$r1, var2617=$z0, var1621=$r2}
; {r0=var1119, null_type=var1983, $r1=var1438, $z0=var2617, $r2=var1621}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$r1 = "\n\t\t\n\t\t\n\ue000\ue001\ue002\n\t\t\t\t\n";	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z0 == 0 goto $r2 = r0;	$r2 = r0;	return $r2
;block_num 3