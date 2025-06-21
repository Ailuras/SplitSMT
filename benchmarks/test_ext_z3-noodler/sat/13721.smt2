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

(declare-sort var3343 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-String String)
(declare-const var814 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var814 null-String)))
(define-const var3197 String "\n\t\t\n\t\t\n\ue000\ue001\ue002\n\t\t\t\t\n") ; Statement: $r1 = "\n\t\t\n\t\t\n\ue000\ue001\ue002\n\t\t\t\t\n" 
(assert true)
(define-const var1513 Bool (= var3197 var814)) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = r0 
(assert (not (= (ite var1513 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1907 String null-String) ; Statement: $r2 = null 
 ; Statement: goto [?= return $r2] 
(assert true) ; Non Conditional
 ; Statement: return $r2 
(check-sat)
; {}
; {var814=r0, var3343=null_type, var3197=$r1, var1513=$z0, var1907=$r2}
; {r0=var814, null_type=var3343, $r1=var3197, $z0=var1513, $r2=var1907}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$r1 = "\n\t\t\n\t\t\n\ue000\ue001\ue002\n\t\t\t\t\n";	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z0 == 0 goto $r2 = r0;	$r2 = null;	goto [?= return $r2];	return $r2
;block_num 3