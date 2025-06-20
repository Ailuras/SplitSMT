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

(declare-sort var232 0)
(declare-sort var642 0)
(declare-sort var2745 0)
(declare-sort var1974 0)
(declare-sort var872 0)
(declare-sort var3393 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1974_getUrl/-275947851 (var1974) var2745)
(declare-fun cast-from-var642-to-var1974 (var642) var1974)
(declare-fun getAttribute/-225665909 (var2745 String) var872)
(declare-fun var3393-init () var3393)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getAddress/-2093578336 (var2745) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var3393 String) void)
(declare-const null-var232 var232)
(declare-const null-var642 var642)
(declare-const var2896 var232) ; Statement: r11 := @this: org.apache.dubbo.registry.integration.RegistryProtocol 
(assert (not (= var2896 null-var232)))
(declare-const var1859 var642) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var1859 null-var642)))
(define-const var2966 var2745 (var1974_getUrl/-275947851 (cast-from-var642-to-var1974 var1859))) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var3165 var872 (getAttribute/-225665909 var2966 "export")) ; Statement: r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.Object getAttribute(java.lang.String)>("export") 
(define-const var2474 Bool false) ; Statement: $z0 = r2 instanceof org.apache.dubbo.common.URL 
 ; Statement: if $z0 != 0 goto $r3 = (org.apache.dubbo.common.URL) r2 
(assert (not (not (= (ite var2474 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var1807 var3393 var3393-init) ; Statement: $r4 = new java.lang.IllegalArgumentException 
(define-const var2383 String String-init) ; Statement: $r5 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2383)) ; Statement: specialinvoke $r5.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2383!1 String)
(assert (= var2383!1 ""))
(assert true)
(define-const var2334 String (append/672562846 var2383!1 "The registry export url is null! registry: ")) ; Statement: $r8 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("The registry export url is null! registry: ") 
(declare-const var2383!2 String)
(assert (= var2383!2 (str.++ var2383!1 "The registry export url is null! registry: ")))
(define-const var854 var2745 (var1974_getUrl/-275947851 (cast-from-var642-to-var1974 var1859))) ; Statement: $r6 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var3167 String (getAddress/-2093578336 var854)) ; Statement: $r7 = virtualinvoke $r6.<org.apache.dubbo.common.URL: java.lang.String getAddress()>() 
(assert true)
(define-const var2397 String (append/672562846 var2334 var3167)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7) 
(declare-const var2334!1 String)
(assert (= var2334!1 (str.++ var2334 var3167)))
(assert true)
(define-const var2681 String (toString/-2075883882 var2397)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var1807 var2681)) ; Statement: specialinvoke $r4.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r10) 

(declare-const var1807!1 var3393)
(declare-const var2681!1 String)
 ; Statement: throw $r4 
(check-sat)
; {var1974_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var642-to-var1974=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), getAttribute/-225665909=([org.apache.dubbo.common.URL, java.lang.String], java.lang.Object), var3393-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getAddress/-2093578336=([org.apache.dubbo.common.URL], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var232=org.apache.dubbo.registry.integration.RegistryProtocol, var2896=r11, var642=org.apache.dubbo.rpc.Invoker, var1859=r0, var2745=org.apache.dubbo.common.URL, var1974=org.apache.dubbo.common.Node, var2966=$r1, var872=java.lang.Object, var3165=r2, var2474=$z0, var3393=java.lang.IllegalArgumentException, var1807=$r4, var2383=$r5, var2334=$r8, var854=$r6, var3167=$r7, var2397=$r9, var2681=$r10}
; {org.apache.dubbo.registry.integration.RegistryProtocol=var232, r11=var2896, org.apache.dubbo.rpc.Invoker=var642, r0=var1859, org.apache.dubbo.common.URL=var2745, org.apache.dubbo.common.Node=var1974, $r1=var2966, java.lang.Object=var872, r2=var3165, $z0=var2474, java.lang.IllegalArgumentException=var3393, $r4=var1807, $r5=var2383, $r8=var2334, $r6=var854, $r7=var3167, $r9=var2397, $r10=var2681}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r11 := @this: org.apache.dubbo.registry.integration.RegistryProtocol;	r0 := @parameter0: org.apache.dubbo.rpc.Invoker;	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.Object getAttribute(java.lang.String)>("export");	$z0 = r2 instanceof org.apache.dubbo.common.URL;	if $z0 != 0 goto $r3 = (org.apache.dubbo.common.URL) r2;	$r4 = new java.lang.IllegalArgumentException;	$r5 = new java.lang.StringBuilder;	specialinvoke $r5.<java.lang.StringBuilder: void <init>()>();	$r8 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("The registry export url is null! registry: ");	$r6 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	$r7 = virtualinvoke $r6.<org.apache.dubbo.common.URL: java.lang.String getAddress()>();	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r4.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r10);	throw $r4
;block_num 2