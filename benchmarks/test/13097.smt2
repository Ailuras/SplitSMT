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

(declare-sort var994 0)
(declare-sort var1172 0)
(declare-sort var333 0)
(declare-sort var669 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var333-init () var333)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getClass/1258963082 (var669) ClassObject)
(declare-fun cast-from-var994-to-var669 (var994) var669)
(declare-fun getSimpleName/-390194377 (ClassObject) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1092629202 (var333 String) void)
(declare-const null-var994 var994)
(declare-const null-var1172 var1172)
(declare-const var1869 var994) ; Statement: r1 := @this: org.apache.dubbo.reactive.AbstractTripleReactorPublisher 
(assert (not (= var1869 null-var994)))
(declare-const var192 var1172) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.protocol.tri.observer.CallStreamObserver 
(assert (not (= var192 null-var1172)))
 ; Statement: if r0 == null goto $r6 = new java.lang.IllegalStateException 
(assert (= var192 null-var1172)) ; Cond: r0 == null 
(define-const var1481 var333 var333-init) ; Statement: $r6 = new java.lang.IllegalStateException 
(define-const var3737 String String-init) ; Statement: $r7 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3737)) ; Statement: specialinvoke $r7.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3737!1 String)
(assert (= var3737!1 ""))
(assert true)
(define-const var3472 ClassObject (getClass/1258963082 (cast-from-var994-to-var669 var1869))) ; Statement: $r8 = virtualinvoke r1.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var3749 String (getSimpleName/-390194377 var3472)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.Class: java.lang.String getSimpleName()>() 
(assert true)
(define-const var3062 String (append/672562846 var3737!1 var3749)) ; Statement: $r10 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9) 
(declare-const var3737!2 String)
(assert (= var3737!2 (str.++ var3737!1 var3749)))
(assert true)
(define-const var1307 String (append/672562846 var3062 " supports only a single subscription")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" supports only a single subscription") 
(declare-const var3062!1 String)
(assert (= var3062!1 (str.++ var3062 " supports only a single subscription")))
(assert true)
(define-const var2454 String (toString/-2075883882 var1307)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1092629202 var1481 var2454)) ; Statement: specialinvoke $r6.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r12) 

(declare-const var1481!1 var333)
(declare-const var2454!1 String)
 ; Statement: throw $r6 
(check-sat)
; {var333-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var994-to-var669=([org.apache.dubbo.reactive.AbstractTripleReactorPublisher], java.lang.Object), getSimpleName/-390194377=([java.lang.Class], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var994=org.apache.dubbo.reactive.AbstractTripleReactorPublisher, var1869=r1, var1172=org.apache.dubbo.rpc.protocol.tri.observer.CallStreamObserver, var192=r0, var333=java.lang.IllegalStateException, var1481=$r6, var3737=$r7, var669=java.lang.Object, var3472=$r8, var3749=$r9, var3062=$r10, var1307=$r11, var2454=$r12}
; {org.apache.dubbo.reactive.AbstractTripleReactorPublisher=var994, r1=var1869, org.apache.dubbo.rpc.protocol.tri.observer.CallStreamObserver=var1172, r0=var192, java.lang.IllegalStateException=var333, $r6=var1481, $r7=var3737, java.lang.Object=var669, $r8=var3472, $r9=var3749, $r10=var3062, $r11=var1307, $r12=var2454}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.reactive.AbstractTripleReactorPublisher;	r0 := @parameter0: org.apache.dubbo.rpc.protocol.tri.observer.CallStreamObserver;	if r0 == null goto $r6 = new java.lang.IllegalStateException;	$r6 = new java.lang.IllegalStateException;	$r7 = new java.lang.StringBuilder;	specialinvoke $r7.<java.lang.StringBuilder: void <init>()>();	$r8 = virtualinvoke r1.<java.lang.Object: java.lang.Class getClass()>();	$r9 = virtualinvoke $r8.<java.lang.Class: java.lang.String getSimpleName()>();	$r10 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" supports only a single subscription");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r6.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r12);	throw $r6
;block_num 2