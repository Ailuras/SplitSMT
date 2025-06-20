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

(declare-sort var130 0)
(declare-sort var293 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getLength-Arr-String-1 ((Array Int String)) Int)
(declare-fun var293-init () var293)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var293 String) void)
(declare-const null-String String)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const null-Bool Bool)
(declare-const var1164 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var1164 null-String)))
(declare-const var1920 (Array Int String)) ; Statement: r0 := @parameter1: java.lang.String[] 
(assert (not (= var1920 null-__Array__Int__String__)))
(declare-const var3424 Bool) ; Statement: z0 := @parameter2: boolean 
(assert (not (= var3424 null-Bool)))
 ; Statement: if z0 != 0 goto $i0 = lengthof r0 
(assert (not (= (ite var3424 1 0) 0))) ; Cond: z0 != 0 
(define-const var2967 Int (getLength-Arr-String-1 var1920)) ; Statement: $i0 = lengthof r0 
 ; Statement: if $i0 == 4 goto return 
(assert (not (= var2967 4))) ; Negate: Cond: $i0 == 4  
(define-const var2015 var293 var293-init) ; Statement: $r1 = new java.lang.IllegalArgumentException 
(define-const var11 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var11)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var11!1 String)
(assert (= var11!1 ""))
(assert true)
(define-const var1216 String (append/672562846 var11!1 "The host is ipv4, but the pattern is not ipv4 pattern : ")) ; Statement: $r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("The host is ipv4, but the pattern is not ipv4 pattern : ") 
(declare-const var11!2 String)
(assert (= var11!2 (str.++ var11!1 "The host is ipv4, but the pattern is not ipv4 pattern : ")))
(assert true)
(define-const var16 String (append/672562846 var1216 var1164)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3) 
(declare-const var1216!1 String)
(assert (= var1216!1 (str.++ var1216 var1164)))
(assert true)
(define-const var1891 String (toString/-2075883882 var16)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var2015 var1891)) ; Statement: specialinvoke $r1.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r6) 

(declare-const var2015!1 var293)
(declare-const var1891!1 String)
 ; Statement: throw $r1 
(check-sat)
; {getLength-Arr-String-1=([java.lang.String[]], int), var293-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var1164=r3, var130=null_type, var1920=r0, var3424=z0, var2967=$i0, var293=java.lang.IllegalArgumentException, var2015=$r1, var11=$r2, var1216=$r4, var16=$r5, var1891=$r6}
; {r3=var1164, null_type=var130, r0=var1920, z0=var3424, $i0=var2967, java.lang.IllegalArgumentException=var293, $r1=var2015, $r2=var11, $r4=var1216, $r5=var16, $r6=var1891}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r3 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String[];	z0 := @parameter2: boolean;	if z0 != 0 goto $i0 = lengthof r0;	$i0 = lengthof r0;	if $i0 == 4 goto return;	$r1 = new java.lang.IllegalArgumentException;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("The host is ipv4, but the pattern is not ipv4 pattern : ");	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r1.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r6);	throw $r1
;block_num 3