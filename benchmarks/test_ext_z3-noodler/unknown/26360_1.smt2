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

(declare-sort var3391 0)
(declare-sort var874 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var874-init () var874)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun length/1134182516 (var3391) Int)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/1107025377 (var874 String) void)
(declare-const null-var3391 var3391)
(declare-const null-Int Int)
(declare-const var967 var3391) ; Statement: r4 := @this: org.apache.dubbo.rpc.protocol.tri.rest.util.KeyString 
(assert (not (= var967 null-var3391)))
(declare-const var1227 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var1227 null-Int)))
 ; Statement: if i0 < 0 goto $r11 = new java.lang.IndexOutOfBoundsException 
(assert (< var1227 0)) ; Cond: i0 < 0 
(define-const var3399 var874 var874-init) ; Statement: $r11 = new java.lang.IndexOutOfBoundsException 
(define-const var3328 String String-init) ; Statement: $r10 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3328)) ; Statement: specialinvoke $r10.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3328!1 String)
(assert (= var3328!1 ""))
(assert true)
(define-const var806 String (append/672562846 var3328!1 "index: ")) ; Statement: $r2 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("index: ") 
(declare-const var3328!2 String)
(assert (= var3328!2 (str.++ var3328!1 "index: ")))
(assert true)
(define-const var1685 String (append/-1001720160 var806 var1227)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var806!1 String)
(assert (str.prefixof var806 var806!1))
(assert true)
(define-const var1960 String (append/672562846 var1685 " must be in the range [0,")) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" must be in the range [0,") 
(declare-const var1685!1 String)
(assert (= var1685!1 (str.++ var1685 " must be in the range [0,")))
(define-const var1770 Int (length/1134182516 var967)) ; Statement: $i1 = r4.<org.apache.dubbo.rpc.protocol.tri.rest.util.KeyString: int length> 
(assert true)
(define-const var3605 String (append/-1001720160 var1960 var1770)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i1) 
(declare-const var1960!1 String)
(assert (str.prefixof var1960 var1960!1))
(assert true)
(define-const var3385 String (append/672562846 var3605 ")")) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(")") 
(declare-const var3605!1 String)
(assert (= var3605!1 (str.++ var3605 ")")))
(assert true)
(define-const var2339 String (toString/-2075883882 var3385)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/1107025377 var3399 var2339)) ; Statement: specialinvoke $r11.<java.lang.IndexOutOfBoundsException: void <init>(java.lang.String)>($r8) 

(declare-const var3399!1 var874)
(declare-const var2339!1 String)
 ; Statement: throw $r11 
(check-sat)
; {var874-init=([], java.lang.IndexOutOfBoundsException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), length/1134182516=([org.apache.dubbo.rpc.protocol.tri.rest.util.KeyString], int), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/1107025377=([java.lang.IndexOutOfBoundsException, java.lang.String], void)}
; {var3391=org.apache.dubbo.rpc.protocol.tri.rest.util.KeyString, var967=r4, var1227=i0, var874=java.lang.IndexOutOfBoundsException, var3399=$r11, var3328=$r10, var806=$r2, var1685=$r3, var1960=$r5, var1770=$i1, var3605=$r6, var3385=$r7, var2339=$r8}
; {org.apache.dubbo.rpc.protocol.tri.rest.util.KeyString=var3391, r4=var967, i0=var1227, java.lang.IndexOutOfBoundsException=var874, $r11=var3399, $r10=var3328, $r2=var806, $r3=var1685, $r5=var1960, $i1=var1770, $r6=var3605, $r7=var3385, $r8=var2339}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r4 := @this: org.apache.dubbo.rpc.protocol.tri.rest.util.KeyString;	i0 := @parameter0: int;	if i0 < 0 goto $r11 = new java.lang.IndexOutOfBoundsException;	$r11 = new java.lang.IndexOutOfBoundsException;	$r10 = new java.lang.StringBuilder;	specialinvoke $r10.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("index: ");	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" must be in the range [0,");	$i1 = r4.<org.apache.dubbo.rpc.protocol.tri.rest.util.KeyString: int length>;	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i1);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(")");	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r11.<java.lang.IndexOutOfBoundsException: void <init>(java.lang.String)>($r8);	throw $r11
;block_num 2