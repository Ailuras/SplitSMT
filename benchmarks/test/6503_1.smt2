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

(declare-sort var2261 0)
(declare-sort var1434 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1434-init () var1434)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var1434 String) void)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var186 String) ; Statement: r49 := @parameter0: java.lang.String 
(assert (not (= var186 null-String)))
(declare-const var25 String) ; Statement: r50 := @parameter1: java.lang.String 
(assert (not (= var25 null-String)))
(declare-const var2444 Int) ; Statement: i6 := @parameter2: int 
(assert (not (= var2444 null-Int)))
 ; Statement: if r49 == null goto $r0 = new java.lang.IllegalArgumentException 
(assert (= var186 null-String)) ; Cond: r49 == null 
(define-const var3247 var1434 var1434-init) ; Statement: $r0 = new java.lang.IllegalArgumentException 
(define-const var1933 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1933)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1933!1 String)
(assert (= var1933!1 ""))
(assert true)
(define-const var2655 String (append/672562846 var1933!1 "Illegal Argument pattern or hostName. Pattern:")) ; Statement: $r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Illegal Argument pattern or hostName. Pattern:") 
(declare-const var1933!2 String)
(assert (= var1933!2 (str.++ var1933!1 "Illegal Argument pattern or hostName. Pattern:")))
(assert true)
(define-const var1834 String (append/672562846 var2655 var186)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r49) 
(declare-const var2655!1 String)
(assert (= var2655!1 (str.++ var2655 var186)))
(assert true)
(define-const var1892 String (append/672562846 var1834 ", Host:")) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", Host:") 
(declare-const var1834!1 String)
(assert (= var1834!1 (str.++ var1834 ", Host:")))
(assert true)
(define-const var2397 String (append/672562846 var1892 var25)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r50) 
(declare-const var1892!1 String)
(assert (= var1892!1 (str.++ var1892 var25)))
(assert true)
(define-const var429 String (toString/-2075883882 var2397)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var3247 var429)) ; Statement: specialinvoke $r0.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r6) 

(declare-const var3247!1 var1434)
(declare-const var429!1 String)
 ; Statement: throw $r0 
(check-sat)
; {var1434-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var186=r49, var2261=null_type, var25=r50, var2444=i6, var1434=java.lang.IllegalArgumentException, var3247=$r0, var1933=$r1, var2655=$r2, var1834=$r3, var1892=$r4, var2397=$r5, var429=$r6}
; {r49=var186, null_type=var2261, r50=var25, i6=var2444, java.lang.IllegalArgumentException=var1434, $r0=var3247, $r1=var1933, $r2=var2655, $r3=var1834, $r4=var1892, $r5=var2397, $r6=var429}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r49 := @parameter0: java.lang.String;	r50 := @parameter1: java.lang.String;	i6 := @parameter2: int;	if r49 == null goto $r0 = new java.lang.IllegalArgumentException;	$r0 = new java.lang.IllegalArgumentException;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Illegal Argument pattern or hostName. Pattern:");	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r49);	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", Host:");	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r50);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r0.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r6);	throw $r0
;block_num 2