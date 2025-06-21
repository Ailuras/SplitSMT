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

(declare-sort var3848 0)
(declare-sort var2389 0)
(declare-sort var3270 0)
(declare-sort var587 0)
(declare-sort var684 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun type/-1855590362 (var3848) ClassObject)
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun toString/-2075883882 ((s String)) String s)
(define-fun <init>/-1061048412 ((s String)) String s)
(declare-fun exceptions/-1855590362 (var3848) var3270)
(declare-fun var3270_entrySet/1101202697 (var3270) var587)
(declare-fun var587_iterator/1911472585 (var587) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-fun var684-init () var684)
(declare-fun <init>/-1092629202 (var684 String) void)
(declare-const null-var3848 var3848)
(declare-const null-String String)
(declare-const var2853 var3848) ; Statement: r2 := @this: org.apache.dubbo.common.extension.ExtensionLoader 
(assert (not (= var2853 null-var3848)))
(declare-const var2604 String) ; Statement: r7 := @parameter0: java.lang.String 
(assert (not (= var2604 null-String)))
(define-const var1721 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(define-const var2361 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2361)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2361!1 String)
(assert (= var2361!1 ""))
(assert true)
(define-const var2427 String (append/672562846 var2361!1 "No such extension ")) ; Statement: $r5 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("No such extension ") 
(declare-const var2361!2 String)
(assert (= var2361!2 (str.++ var2361!1 "No such extension ")))
(define-const var3949 ClassObject (type/-1855590362 var2853)) ; Statement: $r3 = r2.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Class type> 
(assert true)
(define-const var3176 String (getName/-1958580599 var3949)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var1438 String (append/672562846 var2427 var3176)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var2427!1 String)
(assert (= var2427!1 (str.++ var2427 var3176)))
(assert true)
(define-const var3726 String (append/672562846 var1438 " by name ")) ; Statement: $r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" by name ") 
(declare-const var1438!1 String)
(assert (= var1438!1 (str.++ var1438 " by name ")))
(assert true)
(define-const var3456 String (append/672562846 var3726 var2604)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r7) 
(declare-const var3726!1 String)
(assert (= var3726!1 (str.++ var3726 var2604)))
(assert true)
(define-const var1934 String (toString/-2075883882 var3456)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1061048412 var1721 var1934)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>($r10) 
(declare-const var1721!1 String)
(assert (= var1721!1 var1934))
(define-const var1510 Int 1) ; Statement: i1 = 1 
(define-const var2590 var3270 (exceptions/-1855590362 var2853)) ; Statement: $r11 = r2.<org.apache.dubbo.common.extension.ExtensionLoader: java.util.Map exceptions> 
(define-const var282 var587 (var3270_entrySet/1101202697 var2590)) ; Statement: $r12 = interfaceinvoke $r11.<java.util.Map: java.util.Set entrySet()>() 
(define-const var473 Iterator (var587_iterator/1911472585 var282)) ; Statement: r13 = interfaceinvoke $r12.<java.util.Set: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var969 Bool (Iterator_hasNext/-1669924200 var473)) ; Statement: $z0 = interfaceinvoke r13.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto (branch) 
(assert (= (ite var969 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: if i1 != 1 goto $r14 = new java.lang.IllegalStateException 
(assert (not (= var1510 1))) ; Cond: i1 != 1 
(define-const var2145 var684 var684-init) ; Statement: $r14 = new java.lang.IllegalStateException 
(assert true)
(define-const var1558 String (toString/-2075883882 var1721!1)) ; Statement: $r15 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1092629202 var2145 var1558)) ; Statement: specialinvoke $r14.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r15) 

(declare-const var2145!1 var684)
(declare-const var1558!1 String)
 ; Statement: return $r14 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), type/-1855590362=([org.apache.dubbo.common.extension.ExtensionLoader], java.lang.Class), getName/-1958580599=([java.lang.Class], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1061048412=([java.lang.StringBuilder, java.lang.String], void), exceptions/-1855590362=([org.apache.dubbo.common.extension.ExtensionLoader], java.util.Map), var3270_entrySet/1101202697=([java.util.Map], java.util.Set), var587_iterator/1911472585=([java.util.Set], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), var684-init=([], java.lang.IllegalStateException), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var3848=org.apache.dubbo.common.extension.ExtensionLoader, var2853=r2, var2604=r7, var2389=null_type, var1721=$r0, var2361=$r1, var2427=$r5, var3949=$r3, var3176=$r4, var1438=$r6, var3726=$r8, var3456=$r9, var1934=$r10, var1510=i1, var3270=java.util.Map, var2590=$r11, var587=java.util.Set, var282=$r12, var473=r13, var969=$z0, var684=java.lang.IllegalStateException, var2145=$r14, var1558=$r15}
; {org.apache.dubbo.common.extension.ExtensionLoader=var3848, r2=var2853, r7=var2604, null_type=var2389, $r0=var1721, $r1=var2361, $r5=var2427, $r3=var3949, $r4=var3176, $r6=var1438, $r8=var3726, $r9=var3456, $r10=var1934, i1=var1510, java.util.Map=var3270, $r11=var2590, java.util.Set=var587, $r12=var282, r13=var473, $z0=var969, java.lang.IllegalStateException=var684, $r14=var2145, $r15=var1558}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: void <init>(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 2,"<java.lang.StringBuilder: void <init>(java.lang.String)>": 1}
;stmts r2 := @this: org.apache.dubbo.common.extension.ExtensionLoader;	r7 := @parameter0: java.lang.String;	$r0 = new java.lang.StringBuilder;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("No such extension ");	$r3 = r2.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Class type>;	$r4 = virtualinvoke $r3.<java.lang.Class: java.lang.String getName()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" by name ");	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r7);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>($r10);	i1 = 1;	$r11 = r2.<org.apache.dubbo.common.extension.ExtensionLoader: java.util.Map exceptions>;	$r12 = interfaceinvoke $r11.<java.util.Map: java.util.Set entrySet()>();	r13 = interfaceinvoke $r12.<java.util.Set: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r13.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto (branch);	if i1 != 1 goto $r14 = new java.lang.IllegalStateException;	$r14 = new java.lang.IllegalStateException;	$r15 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r14.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r15);	return $r14
;block_num 4