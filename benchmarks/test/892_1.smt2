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

(declare-sort var3005 0)
(declare-sort var2160 0)
(declare-sort var2613 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun routerName/161563782 (var3005) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1166366385 (String Int) String)
(declare-fun total/161563782 (var3005) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun grouping/161563782 (var3005) var2160)
(declare-fun var2160_entrySet/1101202697 (var2160) var2613)
(declare-fun var2613_iterator/1911472585 (var2613) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3005 var3005)
(declare-const var3159 var3005) ; Statement: r1 := @this: org.apache.dubbo.rpc.cluster.router.state.RouterGroupingState 
(assert (not (= var3159 null-var3005)))
(define-const var2334 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2334)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2334!1 String)
(assert (= var2334!1 ""))
(define-const var1308 String (routerName/161563782 var3159)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.cluster.router.state.RouterGroupingState: java.lang.String routerName> 
(assert true)
(define-const var2145 String (append/672562846 var2334!1 var1308)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var2334!2 String)
(assert (= var2334!2 (str.++ var2334!1 var1308)))
(assert true)
(define-const var2796 String (append/-1166366385 var2145 32)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32) 
(declare-const var2145!1 String)
(assert (str.prefixof var2145 var2145!1))
(assert true)
(define-const var3041 String (append/672562846 var2796 " Total: ")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" Total: ") 
(declare-const var2796!1 String)
(assert (= var2796!1 (str.++ var2796 " Total: ")))
(define-const var2943 Int (total/161563782 var3159)) ; Statement: $i0 = r1.<org.apache.dubbo.rpc.cluster.router.state.RouterGroupingState: int total> 
(assert true)
(define-const var3754 String (append/-1001720160 var3041 var2943)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var3041!1 String)
(assert (str.prefixof var3041 var3041!1))
(assert true)
;(assert (append/672562846 var3754 "\n")) ; Statement: virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n") 
(declare-const var3754!1 String)
(assert (= var3754!1 (str.++ var3754 "\n")))
(define-const var2544 var2160 (grouping/161563782 var3159)) ; Statement: $r7 = r1.<org.apache.dubbo.rpc.cluster.router.state.RouterGroupingState: java.util.Map grouping> 
(define-const var3015 var2613 (var2160_entrySet/1101202697 var2544)) ; Statement: $r8 = interfaceinvoke $r7.<java.util.Map: java.util.Set entrySet()>() 
(define-const var1491 Iterator (var2613_iterator/1911472585 var3015)) ; Statement: r9 = interfaceinvoke $r8.<java.util.Set: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var1504 Bool (Iterator_hasNext/-1669924200 var1491)) ; Statement: $z0 = interfaceinvoke r9.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto $r10 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= (ite var1504 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var3203 String (toString/-2075883882 var2334!2)) ; Statement: $r10 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r10 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), routerName/161563782=([org.apache.dubbo.rpc.cluster.router.state.RouterGroupingState], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), total/161563782=([org.apache.dubbo.rpc.cluster.router.state.RouterGroupingState], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), grouping/161563782=([org.apache.dubbo.rpc.cluster.router.state.RouterGroupingState], java.util.Map), var2160_entrySet/1101202697=([java.util.Map], java.util.Set), var2613_iterator/1911472585=([java.util.Set], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3005=org.apache.dubbo.rpc.cluster.router.state.RouterGroupingState, var3159=r1, var2334=$r0, var1308=$r2, var2145=$r3, var2796=$r4, var3041=$r5, var2943=$i0, var3754=$r6, var2160=java.util.Map, var2544=$r7, var2613=java.util.Set, var3015=$r8, var1491=r9, var1504=$z0, var3203=$r10}
; {org.apache.dubbo.rpc.cluster.router.state.RouterGroupingState=var3005, r1=var3159, $r0=var2334, $r2=var1308, $r3=var2145, $r4=var2796, $r5=var3041, $i0=var2943, $r6=var3754, java.util.Map=var2160, $r7=var2544, java.util.Set=var2613, $r8=var3015, r9=var1491, $z0=var1504, $r10=var3203}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.cluster.router.state.RouterGroupingState;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = r1.<org.apache.dubbo.rpc.cluster.router.state.RouterGroupingState: java.lang.String routerName>;	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" Total: ");	$i0 = r1.<org.apache.dubbo.rpc.cluster.router.state.RouterGroupingState: int total>;	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n");	$r7 = r1.<org.apache.dubbo.rpc.cluster.router.state.RouterGroupingState: java.util.Map grouping>;	$r8 = interfaceinvoke $r7.<java.util.Map: java.util.Set entrySet()>();	r9 = interfaceinvoke $r8.<java.util.Set: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r9.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto $r10 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r10 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r10
;block_num 3