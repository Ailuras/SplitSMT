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

(declare-sort var470 0)
(declare-sort var3046 0)
(declare-sort var3611 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun filter/614042624 (var470) var3046)
(declare-fun var3611_getClass/1258963082 (var3611) ClassObject)
(declare-fun cast-from-var3046-to-var3611 (var3046) var3611)
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var470 var470)
(declare-const var2939 var470) ; Statement: r1 := @this: org.apache.dubbo.rpc.cluster.filter.FilterChainBuilder$CopyOfFilterChainNode 
(assert (not (= var2939 null-var470)))
(define-const var2561 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2561)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2561!1 String)
(assert (= var2561!1 ""))
(assert true)
(define-const var2112 String (append/672562846 var2561!1 "Filter ")) ; Statement: $r5 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Filter ") 
(declare-const var2561!2 String)
(assert (= var2561!2 (str.++ var2561!1 "Filter ")))
(define-const var2019 var3046 (filter/614042624 var2939)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.cluster.filter.FilterChainBuilder$CopyOfFilterChainNode: org.apache.dubbo.rpc.BaseFilter filter> 
(define-const var1798 ClassObject (var3611_getClass/1258963082 (cast-from-var3046-to-var3611 var2019))) ; Statement: $r3 = interfaceinvoke $r2.<org.apache.dubbo.rpc.BaseFilter: java.lang.Class getClass()>() 
(assert true)
(define-const var51 String (getName/-1958580599 var1798)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var1319 String (append/672562846 var2112 var51)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var2112!1 String)
(assert (= var2112!1 (str.++ var2112 var51)))
(assert true)
(define-const var2568 String (append/672562846 var1319 " invoke.")) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" invoke.") 
(declare-const var1319!1 String)
(assert (= var1319!1 (str.++ var1319 " invoke.")))
(assert true)
(define-const var3447 String (toString/-2075883882 var2568)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r8 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), filter/614042624=([org.apache.dubbo.rpc.cluster.filter.FilterChainBuilder$CopyOfFilterChainNode], org.apache.dubbo.rpc.BaseFilter), var3611_getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var3046-to-var3611=([org.apache.dubbo.rpc.BaseFilter], java.lang.Object), getName/-1958580599=([java.lang.Class], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var470=org.apache.dubbo.rpc.cluster.filter.FilterChainBuilder$CopyOfFilterChainNode, var2939=r1, var2561=$r0, var2112=$r5, var3046=org.apache.dubbo.rpc.BaseFilter, var2019=$r2, var3611=java.lang.Object, var1798=$r3, var51=$r4, var1319=$r6, var2568=$r7, var3447=$r8}
; {org.apache.dubbo.rpc.cluster.filter.FilterChainBuilder$CopyOfFilterChainNode=var470, r1=var2939, $r0=var2561, $r5=var2112, org.apache.dubbo.rpc.BaseFilter=var3046, $r2=var2019, java.lang.Object=var3611, $r3=var1798, $r4=var51, $r6=var1319, $r7=var2568, $r8=var3447}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.cluster.filter.FilterChainBuilder$CopyOfFilterChainNode;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Filter ");	$r2 = r1.<org.apache.dubbo.rpc.cluster.filter.FilterChainBuilder$CopyOfFilterChainNode: org.apache.dubbo.rpc.BaseFilter filter>;	$r3 = interfaceinvoke $r2.<org.apache.dubbo.rpc.BaseFilter: java.lang.Class getClass()>();	$r4 = virtualinvoke $r3.<java.lang.Class: java.lang.String getName()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" invoke.");	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	return $r8
;block_num 1