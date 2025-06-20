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

(declare-sort var2910 0)
(declare-sort var2008 0)
(declare-sort var1820 0)
(declare-sort var792 0)
(declare-sort var3197 0)
(declare-sort var3001 0)
(declare-sort var2331 0)
(declare-sort var593 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2008-init () var2008)
(declare-fun <init>/-325640736 (var2008) void)
(declare-fun registryMap/1076271234 (var2910) var792)
(declare-fun var792_values/371402559 (var792) var3197)
(declare-fun var3197_iterator/-1617794947 (var3197) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var593_size/-959786421 (var593) Int)
(declare-fun cast-from-var2008-to-var593 (var2008) var593)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3001_info/484404803 (var3001 String) void)
(declare-fun notify/1174860018 (var2910 var593) void)
(declare-const null-var2910 var2910)
(declare-const null-var1820 var1820)
(declare-const var2331-LOGGER var3001)
(declare-const var2314 var2910) ; Statement: r1 := @this: org.apache.dubbo.registry.multiple.MultipleRegistry$MultipleNotifyListenerWrapper 
(assert (not (= var2314 null-var2910)))
(define-const var2525 var2008 var2008-init) ; Statement: $r0 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var2525)) ; Statement: specialinvoke $r0.<java.util.ArrayList: void <init>()>() 

(declare-const var2525!1 var2008)
(define-const var2752 var1820 null-var1820) ; Statement: r20 = null 
(define-const var2015 var792 (registryMap/1076271234 var2314)) ; Statement: $r2 = r1.<org.apache.dubbo.registry.multiple.MultipleRegistry$MultipleNotifyListenerWrapper: java.util.Map registryMap> 
(define-const var1099 var3197 (var792_values/371402559 var2015)) ; Statement: $r3 = interfaceinvoke $r2.<java.util.Map: java.util.Collection values()>() 
(define-const var3103 Iterator (var3197_iterator/-1617794947 var1099)) ; Statement: r4 = interfaceinvoke $r3.<java.util.Collection: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var1040 Bool (Iterator_hasNext/-1669924200 var3103)) ; Statement: $z3 = interfaceinvoke r4.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z3 == 0 goto (branch) 
(assert (= (ite var1040 1 0) 0)) ; Cond: $z3 == 0 
 ; Statement: if r20 == null goto $r6 = <org.apache.dubbo.registry.multiple.MultipleRegistry: org.apache.dubbo.common.logger.Logger LOGGER> 
(assert (= var2752 null-var1820)) ; Cond: r20 == null 
(define-const var622 var3001 var2331-LOGGER) ; Statement: $r6 = <org.apache.dubbo.registry.multiple.MultipleRegistry: org.apache.dubbo.common.logger.Logger LOGGER> 
(define-const var1705 String String-init) ; Statement: $r5 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1705)) ; Statement: specialinvoke $r5.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1705!1 String)
(assert (= var1705!1 ""))
(assert true)
(define-const var2012 String (append/672562846 var1705!1 "Aggregated provider url size ")) ; Statement: $r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Aggregated provider url size ") 
(declare-const var1705!2 String)
(assert (= var1705!2 (str.++ var1705!1 "Aggregated provider url size ")))
(define-const var1984 Int (var593_size/-959786421 (cast-from-var2008-to-var593 var2525!1))) ; Statement: $i0 = interfaceinvoke $r0.<java.util.List: int size()>() 
(assert true)
(define-const var941 String (append/-1001720160 var2012 var1984)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var2012!1 String)
(assert (str.prefixof var2012 var2012!1))
(assert true)
(define-const var68 String (toString/-2075883882 var941)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var3001_info/484404803 var622 var68)) ; Statement: interfaceinvoke $r6.<org.apache.dubbo.common.logger.Logger: void info(java.lang.String)>($r9) 

(declare-const var622!1 var3001)
(declare-const var68!1 String)
(assert true) ; Non Conditional
(assert true)
;(assert (notify/1174860018 var2314 (cast-from-var2008-to-var593 var2525!1))) ; Statement: virtualinvoke r1.<org.apache.dubbo.registry.multiple.MultipleRegistry$MultipleNotifyListenerWrapper: void notify(java.util.List)>($r0) 

(declare-const var2314!1 var2910)
(declare-const var2525!2 var2008)
 ; Statement: return 
(check-sat)
; {var2008-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), registryMap/1076271234=([org.apache.dubbo.registry.multiple.MultipleRegistry$MultipleNotifyListenerWrapper], java.util.Map), var792_values/371402559=([java.util.Map], java.util.Collection), var3197_iterator/-1617794947=([java.util.Collection], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var593_size/-959786421=([java.util.List], int), cast-from-var2008-to-var593=([java.util.ArrayList], java.util.List), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3001_info/484404803=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), notify/1174860018=([org.apache.dubbo.registry.multiple.MultipleRegistry$MultipleNotifyListenerWrapper, java.util.List], void)}
; {var2910=org.apache.dubbo.registry.multiple.MultipleRegistry$MultipleNotifyListenerWrapper, var2314=r1, var2008=java.util.ArrayList, var2525=$r0, var1820=org.apache.dubbo.common.URL, var2752=r20, var792=java.util.Map, var2015=$r2, var3197=java.util.Collection, var1099=$r3, var3103=r4, var1040=$z3, var3001=org.apache.dubbo.common.logger.Logger, var2331=org.apache.dubbo.registry.multiple.MultipleRegistry, var622=$r6, var1705=$r5, var2012=$r7, var593=java.util.List, var1984=$i0, var941=$r8, var68=$r9}
; {org.apache.dubbo.registry.multiple.MultipleRegistry$MultipleNotifyListenerWrapper=var2910, r1=var2314, java.util.ArrayList=var2008, $r0=var2525, org.apache.dubbo.common.URL=var1820, r20=var2752, java.util.Map=var792, $r2=var2015, java.util.Collection=var3197, $r3=var1099, r4=var3103, $z3=var1040, org.apache.dubbo.common.logger.Logger=var3001, org.apache.dubbo.registry.multiple.MultipleRegistry=var2331, $r6=var622, $r5=var1705, $r7=var2012, java.util.List=var593, $i0=var1984, $r8=var941, $r9=var68}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.registry.multiple.MultipleRegistry$MultipleNotifyListenerWrapper;	$r0 = new java.util.ArrayList;	specialinvoke $r0.<java.util.ArrayList: void <init>()>();	r20 = null;	$r2 = r1.<org.apache.dubbo.registry.multiple.MultipleRegistry$MultipleNotifyListenerWrapper: java.util.Map registryMap>;	$r3 = interfaceinvoke $r2.<java.util.Map: java.util.Collection values()>();	r4 = interfaceinvoke $r3.<java.util.Collection: java.util.Iterator iterator()>();	$z3 = interfaceinvoke r4.<java.util.Iterator: boolean hasNext()>();	if $z3 == 0 goto (branch);	if r20 == null goto $r6 = <org.apache.dubbo.registry.multiple.MultipleRegistry: org.apache.dubbo.common.logger.Logger LOGGER>;	$r6 = <org.apache.dubbo.registry.multiple.MultipleRegistry: org.apache.dubbo.common.logger.Logger LOGGER>;	$r5 = new java.lang.StringBuilder;	specialinvoke $r5.<java.lang.StringBuilder: void <init>()>();	$r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Aggregated provider url size ");	$i0 = interfaceinvoke $r0.<java.util.List: int size()>();	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r6.<org.apache.dubbo.common.logger.Logger: void info(java.lang.String)>($r9);	virtualinvoke r1.<org.apache.dubbo.registry.multiple.MultipleRegistry$MultipleNotifyListenerWrapper: void notify(java.util.List)>($r0);	return
;block_num 5