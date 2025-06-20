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

(declare-sort var2431 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2431-init () var2431)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var2431 String) void)
(declare-const null-Int Int)
(declare-const var996 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var996 null-Int)))
 ; Statement: if i0 >= 3 goto (branch) 
(assert (not (>= var996 3))) ; Negate: Cond: i0 >= 3  
 ; Statement: if i0 >= 0 goto $i2 = i0 + 1 
(assert (not (>= var996 0))) ; Negate: Cond: i0 >= 0  
(define-const var3259 var2431 var2431-init) ; Statement: $r0 = new java.lang.IllegalArgumentException 
(define-const var3885 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3885)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3885!1 String)
(assert (= var3885!1 ""))
(assert true)
(define-const var460 String (append/672562846 var3885!1 "expectedSize cannot be negative but was: ")) ; Statement: $r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("expectedSize cannot be negative but was: ") 
(declare-const var3885!2 String)
(assert (= var3885!2 (str.++ var3885!1 "expectedSize cannot be negative but was: ")))
(assert true)
(define-const var2541 String (append/-1001720160 var460 var996)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var460!1 String)
(assert (str.prefixof var460 var460!1))
(assert true)
(define-const var3626 String (toString/-2075883882 var2541)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var3259 var3626)) ; Statement: specialinvoke $r0.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r4) 

(declare-const var3259!1 var2431)
(declare-const var3626!1 String)
 ; Statement: throw $r0 
(check-sat)
; {var2431-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var996=i0, var2431=java.lang.IllegalArgumentException, var3259=$r0, var3885=$r1, var460=$r2, var2541=$r3, var3626=$r4}
; {i0=var996, java.lang.IllegalArgumentException=var2431, $r0=var3259, $r1=var3885, $r2=var460, $r3=var2541, $r4=var3626}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts i0 := @parameter0: int;	if i0 >= 3 goto (branch);	if i0 >= 0 goto $i2 = i0 + 1;	$r0 = new java.lang.IllegalArgumentException;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("expectedSize cannot be negative but was: ");	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r0.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r4);	throw $r0
;block_num 3