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

(declare-sort var474 0)
(declare-sort var831 0)
(declare-sort var1907 0)
(declare-sort var915 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getClass/1258963082 (var831) ClassObject)
(declare-fun cast-from-var474-to-var831 (var474) var831)
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getStatusCode/317030545 (var1907) Int)
(declare-fun cast-from-var474-to-var1907 (var474) var1907)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun getErrorCode/739026448 (var474) String)
(declare-fun getMessage/849299655 (var915) String)
(declare-fun cast-from-var474-to-var915 (var474) var915)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var474 var474)
(declare-const var2647 var474) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.RestException 
(assert (not (= var2647 null-var474)))
(define-const var463 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var463)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var463!1 String)
(assert (= var463!1 ""))
(assert true)
(define-const var1637 ClassObject (getClass/1258963082 (cast-from-var474-to-var831 var2647))) ; Statement: $r2 = virtualinvoke r1.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var1599 String (getName/-1958580599 var1637)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var3281 String (append/672562846 var463!1 var1599)) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var463!2 String)
(assert (= var463!2 (str.++ var463!1 var1599)))
(assert true)
(define-const var1883 String (append/672562846 var3281 ": status=")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(": status=") 
(declare-const var3281!1 String)
(assert (= var3281!1 (str.++ var3281 ": status=")))
(assert true)
(define-const var1976 Int (getStatusCode/317030545 (cast-from-var474-to-var1907 var2647))) ; Statement: $i0 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.RestException: int getStatusCode()>() 
(assert true)
(define-const var1979 String (append/-1001720160 var1883 var1976)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var1883!1 String)
(assert (str.prefixof var1883 var1883!1))
(assert true)
(define-const var1949 String (append/672562846 var1979 ", ")) ; Statement: $r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", ") 
(declare-const var1979!1 String)
(assert (= var1979!1 (str.++ var1979 ", ")))
(assert true)
(define-const var2296 String (getErrorCode/739026448 var2647)) ; Statement: $r7 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.RestException: java.lang.String getErrorCode()>() 
(assert true)
(define-const var2034 String (append/672562846 var1949 var2296)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7) 
(declare-const var1949!1 String)
(assert (= var1949!1 (str.++ var1949 var2296)))
(assert true)
(define-const var366 String (append/672562846 var2034 ", ")) ; Statement: $r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", ") 
(declare-const var2034!1 String)
(assert (= var2034!1 (str.++ var2034 ", ")))
(assert true)
(define-const var3139 String (getMessage/849299655 (cast-from-var474-to-var915 var2647))) ; Statement: $r10 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.RestException: java.lang.String getMessage()>() 
(assert true)
(define-const var1213 String (append/672562846 var366 var3139)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10) 
(declare-const var366!1 String)
(assert (= var366!1 (str.++ var366 var3139)))
(assert true)
(define-const var125 String (toString/-2075883882 var1213)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r13 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var474-to-var831=([org.apache.dubbo.rpc.protocol.tri.rest.RestException], java.lang.Object), getName/-1958580599=([java.lang.Class], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getStatusCode/317030545=([org.apache.dubbo.remoting.http12.exception.HttpStatusException], int), cast-from-var474-to-var1907=([org.apache.dubbo.rpc.protocol.tri.rest.RestException], org.apache.dubbo.remoting.http12.exception.HttpStatusException), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), getErrorCode/739026448=([org.apache.dubbo.rpc.protocol.tri.rest.RestException], java.lang.String), getMessage/849299655=([java.lang.Throwable], java.lang.String), cast-from-var474-to-var915=([org.apache.dubbo.rpc.protocol.tri.rest.RestException], java.lang.Throwable), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var474=org.apache.dubbo.rpc.protocol.tri.rest.RestException, var2647=r1, var463=$r0, var831=java.lang.Object, var1637=$r2, var1599=$r3, var3281=$r4, var1883=$r5, var1907=org.apache.dubbo.remoting.http12.exception.HttpStatusException, var1976=$i0, var1979=$r6, var1949=$r8, var2296=$r7, var2034=$r9, var366=$r11, var915=java.lang.Throwable, var3139=$r10, var1213=$r12, var125=$r13}
; {org.apache.dubbo.rpc.protocol.tri.rest.RestException=var474, r1=var2647, $r0=var463, java.lang.Object=var831, $r2=var1637, $r3=var1599, $r4=var3281, $r5=var1883, org.apache.dubbo.remoting.http12.exception.HttpStatusException=var1907, $i0=var1976, $r6=var1979, $r8=var1949, $r7=var2296, $r9=var2034, $r11=var366, java.lang.Throwable=var915, $r10=var3139, $r12=var1213, $r13=var125}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 6,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.RestException;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<java.lang.Object: java.lang.Class getClass()>();	$r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getName()>();	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(": status=");	$i0 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.RestException: int getStatusCode()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", ");	$r7 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.RestException: java.lang.String getErrorCode()>();	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7);	$r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", ");	$r10 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.RestException: java.lang.String getMessage()>();	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>();	return $r13
;block_num 1