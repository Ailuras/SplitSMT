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

(declare-sort var115 0)
(declare-sort var449 0)
(declare-sort var1650 0)
(declare-sort var985 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun destroyed/91014847 (var115) var449)
(declare-fun get/2135855162 (var449) Bool)
(declare-fun var1650-init () var1650)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getClass/1258963082 (var985) ClassObject)
(declare-fun cast-from-var115-to-var985 (var115) var985)
(declare-fun getSimpleName/-390194377 (ClassObject) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1092629202 (var1650 String) void)
(declare-const null-var115 var115)
(declare-const var1042 var115) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol 
(assert (not (= var1042 null-var115)))
(define-const var546 var449 (destroyed/91014847 var1042)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol: java.util.concurrent.atomic.AtomicBoolean destroyed> 
(assert true)
(define-const var3264 Bool (get/2135855162 var546)) ; Statement: $z0 = virtualinvoke $r1.<java.util.concurrent.atomic.AtomicBoolean: boolean get()>() 
 ; Statement: if $z0 == 0 goto return 
(assert (not (= (ite var3264 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var299 var1650 var1650-init) ; Statement: $r2 = new java.lang.IllegalStateException 
(define-const var2340 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2340)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2340!1 String)
(assert (= var2340!1 ""))
(assert true)
(define-const var3119 ClassObject (getClass/1258963082 (cast-from-var115-to-var985 var1042))) ; Statement: $r4 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var3498 String (getSimpleName/-390194377 var3119)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.Class: java.lang.String getSimpleName()>() 
(assert true)
(define-const var3038 String (append/672562846 var2340!1 var3498)) ; Statement: $r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var2340!2 String)
(assert (= var2340!2 (str.++ var2340!1 var3498)))
(assert true)
(define-const var1945 String (append/672562846 var3038 " is destroyed")) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" is destroyed") 
(declare-const var3038!1 String)
(assert (= var3038!1 (str.++ var3038 " is destroyed")))
(assert true)
(define-const var1389 String (toString/-2075883882 var1945)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1092629202 var299 var1389)) ; Statement: specialinvoke $r2.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r8) 

(declare-const var299!1 var1650)
(declare-const var1389!1 String)
 ; Statement: throw $r2 
(check-sat)
; {destroyed/91014847=([org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol], java.util.concurrent.atomic.AtomicBoolean), get/2135855162=([java.util.concurrent.atomic.AtomicBoolean], boolean), var1650-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var115-to-var985=([org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol], java.lang.Object), getSimpleName/-390194377=([java.lang.Class], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var115=org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol, var1042=r0, var449=java.util.concurrent.atomic.AtomicBoolean, var546=$r1, var3264=$z0, var1650=java.lang.IllegalStateException, var299=$r2, var2340=$r3, var985=java.lang.Object, var3119=$r4, var3498=$r5, var3038=$r6, var1945=$r7, var1389=$r8}
; {org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol=var115, r0=var1042, java.util.concurrent.atomic.AtomicBoolean=var449, $r1=var546, $z0=var3264, java.lang.IllegalStateException=var1650, $r2=var299, $r3=var2340, java.lang.Object=var985, $r4=var3119, $r5=var3498, $r6=var3038, $r7=var1945, $r8=var1389}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol;	$r1 = r0.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol: java.util.concurrent.atomic.AtomicBoolean destroyed>;	$z0 = virtualinvoke $r1.<java.util.concurrent.atomic.AtomicBoolean: boolean get()>();	if $z0 == 0 goto return;	$r2 = new java.lang.IllegalStateException;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>();	$r5 = virtualinvoke $r4.<java.lang.Class: java.lang.String getSimpleName()>();	$r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" is destroyed");	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r2.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r8);	throw $r2
;block_num 2