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

(declare-sort var105 0)
(declare-sort var137 0)
(declare-sort var3714 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/1177653502 (var137) void)
(declare-fun cast-from-var105-to-var137 (var105) var137)
(declare-fun var3714-init () var3714)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var3714 String) void)
(declare-const null-var105 var105)
(declare-const null-Int Int)
(declare-const var2290 var105) ; Statement: r0 := @this: org.apache.dubbo.common.io.UnsafeByteArrayOutputStream 
(assert (not (= var2290 null-var105)))
(declare-const var2277 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var2277 null-Int)))
(assert true)
;(assert (<init>/1177653502 (cast-from-var105-to-var137 var2290))) ; Statement: specialinvoke r0.<java.io.OutputStream: void <init>()>() 

(declare-const var2290!1 var105)
 ; Statement: if i0 >= 0 goto $r1 = newarray (byte)[i0] 
(assert (not (>= var2277 0))) ; Negate: Cond: i0 >= 0  
(define-const var1305 var3714 var3714-init) ; Statement: $r2 = new java.lang.IllegalArgumentException 
(define-const var2166 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2166)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2166!1 String)
(assert (= var2166!1 ""))
(assert true)
(define-const var1953 String (append/672562846 var2166!1 "Negative initial size: ")) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Negative initial size: ") 
(declare-const var2166!2 String)
(assert (= var2166!2 (str.++ var2166!1 "Negative initial size: ")))
(assert true)
(define-const var1391 String (append/-1001720160 var1953 var2277)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var1953!1 String)
(assert (str.prefixof var1953 var1953!1))
(assert true)
(define-const var192 String (toString/-2075883882 var1391)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var1305 var192)) ; Statement: specialinvoke $r2.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r6) 

(declare-const var1305!1 var3714)
(declare-const var192!1 String)
 ; Statement: throw $r2 
(check-sat)
; {<init>/1177653502=([java.io.OutputStream], void), cast-from-var105-to-var137=([org.apache.dubbo.common.io.UnsafeByteArrayOutputStream], java.io.OutputStream), var3714-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var105=org.apache.dubbo.common.io.UnsafeByteArrayOutputStream, var2290=r0, var2277=i0, var137=java.io.OutputStream, var3714=java.lang.IllegalArgumentException, var1305=$r2, var2166=$r3, var1953=$r4, var1391=$r5, var192=$r6}
; {org.apache.dubbo.common.io.UnsafeByteArrayOutputStream=var105, r0=var2290, i0=var2277, java.io.OutputStream=var137, java.lang.IllegalArgumentException=var3714, $r2=var1305, $r3=var2166, $r4=var1953, $r5=var1391, $r6=var192}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.io.UnsafeByteArrayOutputStream;	i0 := @parameter0: int;	specialinvoke r0.<java.io.OutputStream: void <init>()>();	if i0 >= 0 goto $r1 = newarray (byte)[i0];	$r2 = new java.lang.IllegalArgumentException;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Negative initial size: ");	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r2.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r6);	throw $r2
;block_num 2