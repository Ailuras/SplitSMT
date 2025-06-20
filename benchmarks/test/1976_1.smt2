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

(declare-sort var2470 0)
(declare-sort var3689 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-String String)
(declare-const null-var3689 var3689)
(declare-const var140 String) ; Statement: r7 := @parameter0: java.lang.String 
(assert (not (= var140 null-String)))
(declare-const var3016 var3689) ; Statement: r10 := @parameter1: java.net.URL 
(assert (not (= var3016 null-var3689)))
(declare-const var1823 String) ; Statement: r0 := @parameter2: java.lang.String 
(assert (not (= var1823 null-String)))
(declare-const var3070 String) ; Statement: r2 := @parameter3: java.lang.String 
(assert (not (= var3070 null-String)))
(define-const var426 String "revision") ; Statement: $r1 = "revision" 
(assert true)
(define-const var256 Bool (= var426 var1823)) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z0 == 0 goto $r32 = "git.commit.id" 
(assert (= (ite var256 1 0) 0)) ; Cond: $z0 == 0 
(define-const var980 String "git.commit.id") ; Statement: $r32 = "git.commit.id" 
(assert true)
(define-const var2813 Bool (= var980 var1823)) ; Statement: $z3 = virtualinvoke $r32.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z3 == 0 goto return 
(assert (= (ite var2813 1 0) 0)) ; Cond: $z3 == 0 
 ; Statement: return 
(check-sat)
; {}
; {var140=r7, var2470=null_type, var3689=java.net.URL, var3016=r10, var1823=r0, var3070=r2, var426=$r1, var256=$z0, var980=$r32, var2813=$z3}
; {r7=var140, null_type=var2470, java.net.URL=var3689, r10=var3016, r0=var1823, r2=var3070, $r1=var426, $z0=var256, $r32=var980, $z3=var2813}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 2}
;stmts r7 := @parameter0: java.lang.String;	r10 := @parameter1: java.net.URL;	r0 := @parameter2: java.lang.String;	r2 := @parameter3: java.lang.String;	$r1 = "revision";	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z0 == 0 goto $r32 = "git.commit.id";	$r32 = "git.commit.id";	$z3 = virtualinvoke $r32.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z3 == 0 goto return;	return
;block_num 3