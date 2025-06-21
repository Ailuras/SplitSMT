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

(declare-sort var465 0)
(declare-sort var1450 0)
(declare-sort var1474 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getClass/1258963082 (var1450) ClassObject)
(declare-fun cast-from-var465-to-var1450 (var465) var1450)
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun statusCode/-1956993962 (var465) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun getMessage/849299655 (var1474) String)
(declare-fun cast-from-var465-to-var1474 (var465) var1474)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var465 var465)
(declare-const var711 var465) ; Statement: r1 := @this: org.apache.dubbo.remoting.http12.exception.HttpStatusException 
(assert (not (= var711 null-var465)))
(define-const var2200 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2200)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2200!1 String)
(assert (= var2200!1 ""))
(assert true)
(define-const var1831 ClassObject (getClass/1258963082 (cast-from-var465-to-var1450 var711))) ; Statement: $r2 = virtualinvoke r1.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var3720 String (getName/-1958580599 var1831)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var1341 String (append/672562846 var2200!1 var3720)) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var2200!2 String)
(assert (= var2200!2 (str.++ var2200!1 var3720)))
(assert true)
(define-const var1931 String (append/672562846 var1341 ": status=")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(": status=") 
(declare-const var1341!1 String)
(assert (= var1341!1 (str.++ var1341 ": status=")))
(define-const var1807 Int (statusCode/-1956993962 var711)) ; Statement: $i0 = r1.<org.apache.dubbo.remoting.http12.exception.HttpStatusException: int statusCode> 
(assert true)
(define-const var1303 String (append/-1001720160 var1931 var1807)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var1931!1 String)
(assert (str.prefixof var1931 var1931!1))
(assert true)
(define-const var2146 String (append/672562846 var1303 ", ")) ; Statement: $r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", ") 
(declare-const var1303!1 String)
(assert (= var1303!1 (str.++ var1303 ", ")))
(assert true)
(define-const var77 String (getMessage/849299655 (cast-from-var465-to-var1474 var711))) ; Statement: $r7 = virtualinvoke r1.<org.apache.dubbo.remoting.http12.exception.HttpStatusException: java.lang.String getMessage()>() 
(assert true)
(define-const var455 String (append/672562846 var2146 var77)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7) 
(declare-const var2146!1 String)
(assert (= var2146!1 (str.++ var2146 var77)))
(assert true)
(define-const var290 String (toString/-2075883882 var455)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r10 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var465-to-var1450=([org.apache.dubbo.remoting.http12.exception.HttpStatusException], java.lang.Object), getName/-1958580599=([java.lang.Class], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), statusCode/-1956993962=([org.apache.dubbo.remoting.http12.exception.HttpStatusException], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), getMessage/849299655=([java.lang.Throwable], java.lang.String), cast-from-var465-to-var1474=([org.apache.dubbo.remoting.http12.exception.HttpStatusException], java.lang.Throwable), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var465=org.apache.dubbo.remoting.http12.exception.HttpStatusException, var711=r1, var2200=$r0, var1450=java.lang.Object, var1831=$r2, var3720=$r3, var1341=$r4, var1931=$r5, var1807=$i0, var1303=$r6, var2146=$r8, var1474=java.lang.Throwable, var77=$r7, var455=$r9, var290=$r10}
; {org.apache.dubbo.remoting.http12.exception.HttpStatusException=var465, r1=var711, $r0=var2200, java.lang.Object=var1450, $r2=var1831, $r3=var3720, $r4=var1341, $r5=var1931, $i0=var1807, $r6=var1303, $r8=var2146, java.lang.Throwable=var1474, $r7=var77, $r9=var455, $r10=var290}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.http12.exception.HttpStatusException;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<java.lang.Object: java.lang.Class getClass()>();	$r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getName()>();	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(": status=");	$i0 = r1.<org.apache.dubbo.remoting.http12.exception.HttpStatusException: int statusCode>;	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", ");	$r7 = virtualinvoke r1.<org.apache.dubbo.remoting.http12.exception.HttpStatusException: java.lang.String getMessage()>();	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	return $r10
;block_num 1