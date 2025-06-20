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

(declare-sort var425 0)
(declare-sort var329 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun toServicePath/1322259465 (var425 var329) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getCategory/-59794707 (var329 String) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var425 var425)
(declare-const null-var329 var329)
(declare-const var2833 var425) ; Statement: r1 := @this: org.apache.dubbo.registry.zookeeper.ZookeeperRegistry 
(assert (not (= var2833 null-var425)))
(declare-const var3982 var329) ; Statement: r2 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var3982 null-var329)))
(define-const var3459 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3459)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3459!1 String)
(assert (= var3459!1 ""))
(assert true)
(define-const var802 String (toServicePath/1322259465 var2833 var3982)) ; Statement: $r3 = specialinvoke r1.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry: java.lang.String toServicePath(org.apache.dubbo.common.URL)>(r2) 
(assert true)
(define-const var3374 String (append/672562846 var3459!1 var802)) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var3459!2 String)
(assert (= var3459!2 (str.++ var3459!1 var802)))
(assert true)
(define-const var2448 String (append/672562846 var3374 "/")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/") 
(declare-const var3374!1 String)
(assert (= var3374!1 (str.++ var3374 "/")))
(assert true)
(define-const var2444 String (getCategory/-59794707 var3982 "providers")) ; Statement: $r5 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getCategory(java.lang.String)>("providers") 
(assert true)
(define-const var2769 String (append/672562846 var2448 var2444)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var2448!1 String)
(assert (= var2448!1 (str.++ var2448 var2444)))
(assert true)
(define-const var2714 String (toString/-2075883882 var2769)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r8 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), toServicePath/1322259465=([org.apache.dubbo.registry.zookeeper.ZookeeperRegistry, org.apache.dubbo.common.URL], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getCategory/-59794707=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var425=org.apache.dubbo.registry.zookeeper.ZookeeperRegistry, var2833=r1, var329=org.apache.dubbo.common.URL, var3982=r2, var3459=$r0, var802=$r3, var3374=$r4, var2448=$r6, var2444=$r5, var2769=$r7, var2714=$r8}
; {org.apache.dubbo.registry.zookeeper.ZookeeperRegistry=var425, r1=var2833, org.apache.dubbo.common.URL=var329, r2=var3982, $r0=var3459, $r3=var802, $r4=var3374, $r6=var2448, $r5=var2444, $r7=var2769, $r8=var2714}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.registry.zookeeper.ZookeeperRegistry;	r2 := @parameter0: org.apache.dubbo.common.URL;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = specialinvoke r1.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry: java.lang.String toServicePath(org.apache.dubbo.common.URL)>(r2);	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/");	$r5 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getCategory(java.lang.String)>("providers");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	return $r8
;block_num 1