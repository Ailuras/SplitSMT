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

(declare-sort var2946 0)
(declare-sort var804 0)
(declare-sort var3360 0)
(declare-sort var391 0)
(declare-sort var1687 0)
(declare-sort var2622 0)
(declare-sort var2049 0)
(declare-sort var2921 0)
(declare-sort var1848 0)
(declare-sort var2620 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2946_get/1088891777 (var2946 var3360) var3360)
(declare-fun cast-from-String-to-var3360 (String) var3360)
(declare-fun cast-from-var3360-to-String (var3360) String)
(declare-fun var391_notEmptyString/1687515918 (String String) void)
(declare-fun String-init () String)
(define-fun <init>/-1061048412 ((s String)) String s)
(declare-fun var1687_isNotEmpty/-1251449450 (String) Bool)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1166366385 (String Int) String)
(declare-fun var2622-init () var2622)
(declare-fun var2946_keySet/-712633290 (var2946) var2049)
(declare-fun <init>/2032108350 (var2622 var2921) void)
(declare-fun cast-from-var2049-to-var2921 (var2049) var2921)
(declare-fun var1848_sort/-787612144 (var2620) void)
(declare-fun cast-from-var2622-to-var2620 (var2622) var2620)
(declare-fun var2620_iterator/-912451715 (var2620) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-fun length/-171891354 (String) Int)
(declare-fun charAt/1621160911 (String Int) Int)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun setCharAt/-2056395727 (String Int Int) void)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2946 var2946)
(declare-const null-var804 var804)
(declare-const var3781 var2946) ; Statement: r0 := @parameter0: java.util.Map 
(assert (not (= var3781 null-var2946)))
(declare-const var2787 var804) ; Statement: r10 := @parameter1: org.springframework.context.ApplicationContext 
(assert (not (= var2787 null-var804)))
(define-const var2136 var3360 (var2946_get/1088891777 var3781 (cast-from-String-to-var3360 "interface"))) ; Statement: $r1 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("interface") 
(define-const var78 String (cast-from-var3360-to-String var2136)) ; Statement: r2 = (java.lang.String) $r1 
;(assert (var391_notEmptyString/1687515918 var78 "No interface class or name found from attributes")) ; Statement: staticinvoke <org.apache.dubbo.common.utils.Assert: void notEmptyString(java.lang.String,java.lang.String)>(r2, "No interface class or name found from attributes") 

(declare-const var78!1 String)
(declare-const var1710 String)
(define-const var3451 var3360 (var2946_get/1088891777 var3781 (cast-from-String-to-var3360 "group"))) ; Statement: $r3 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("group") 
(define-const var3509 String (cast-from-var3360-to-String var3451)) ; Statement: r4 = (java.lang.String) $r3 
(define-const var3244 var3360 (var2946_get/1088891777 var3781 (cast-from-String-to-var3360 "version"))) ; Statement: $r5 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("version") 
(define-const var2664 String (cast-from-var3360-to-String var3244)) ; Statement: r6 = (java.lang.String) $r5 
(define-const var450 String String-init) ; Statement: $r28 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/-1061048412 var450 "ReferenceBean:")) ; Statement: specialinvoke $r28.<java.lang.StringBuilder: void <init>(java.lang.String)>("ReferenceBean:") 
(declare-const var450!1 String)
(assert (= var450!1 "ReferenceBean:"))
(define-const var3328 Bool (var1687_isNotEmpty/-1251449450 var3509)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r4) 
 ; Statement: if $z0 == 0 goto virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(assert (= (ite var3328 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
;(assert (append/672562846 var450!1 var78!1)) ; Statement: virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var450!2 String)
(assert (= var450!2 (str.++ var450!1 var78!1)))
(define-const var1304 Bool (var1687_isNotEmpty/-1251449450 var2664)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r6) 
 ; Statement: if $z1 == 0 goto virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40) 
(assert (= (ite var1304 1 0) 0)) ; Cond: $z1 == 0 
(assert true)
;(assert (append/-1166366385 var450!2 40)) ; Statement: virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40) 
(declare-const var450!3 String)
(assert (str.prefixof var450!2 var450!3))
(define-const var3274 var2622 var2622-init) ; Statement: $r29 = new java.util.ArrayList 
(define-const var972 var2049 (var2946_keySet/-712633290 var3781)) ; Statement: $r9 = interfaceinvoke r0.<java.util.Map: java.util.Set keySet()>() 
(assert true)
;(assert (<init>/2032108350 var3274 (cast-from-var2049-to-var2921 var972))) ; Statement: specialinvoke $r29.<java.util.ArrayList: void <init>(java.util.Collection)>($r9) 

(declare-const var3274!1 var2622)
(declare-const var972!1 var2049)
;(assert (var1848_sort/-787612144 (cast-from-var2622-to-var2620 var3274!1))) ; Statement: staticinvoke <java.util.Collections: void sort(java.util.List)>($r29) 

(declare-const var3274!2 var2622)
(define-const var2520 Iterator (var2620_iterator/-912451715 (cast-from-var2622-to-var2620 var3274!2))) ; Statement: $r22 = interfaceinvoke $r29.<java.util.List: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var1079 Bool (Iterator_hasNext/-1669924200 var2520)) ; Statement: $z3 = interfaceinvoke $r22.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z3 == 0 goto $i0 = virtualinvoke $r28.<java.lang.StringBuilder: int length()>() 
(assert (= (ite var1079 1 0) 0)) ; Cond: $z3 == 0 
(assert true)
(define-const var3036 Int (length/-171891354 var450!3)) ; Statement: $i0 = virtualinvoke $r28.<java.lang.StringBuilder: int length()>() 
(define-const var3942 Int (- var3036 1)) ; Statement: $i1 = $i0 - 1 
(assert true)
(define-const var1957 Int (charAt/1621160911 var450!3 var3942)) ; Statement: $c2 = virtualinvoke $r28.<java.lang.StringBuilder: char charAt(int)>($i1) 
(define-const var2807 Int (cast-from-Int-to-Int var1957)) ; Statement: $i5 = (int) $c2 
 ; Statement: if $i5 != 44 goto virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41) 
(assert (not (not (= var2807 44)))) ; Negate: Cond: $i5 != 44  
(assert true)
(define-const var792 Int (length/-171891354 var450!3)) ; Statement: $i3 = virtualinvoke $r28.<java.lang.StringBuilder: int length()>() 
(define-const var3152 Int (- var792 1)) ; Statement: $i4 = $i3 - 1 
(assert true)
;(assert (setCharAt/-2056395727 var450!3 var3152 41)) ; Statement: virtualinvoke $r28.<java.lang.StringBuilder: void setCharAt(int,char)>($i4, 41) 

(declare-const var450!4 String)
(declare-const var3152!1 Int)
(declare-const var630 Int)
 ; Statement: goto [?= $r14 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.String toString()>()] 
(assert true) ; Non Conditional
(assert true)
(define-const var675 String (toString/-2075883882 var450!4)) ; Statement: $r14 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var1734 String var675) ; Statement: r26 = $r14 
 ; Statement: if r10 == null goto return r26 
(assert (= var2787 null-var804)) ; Cond: r10 == null 
 ; Statement: return r26 
(check-sat)
; {var2946_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var3360=([java.lang.String], java.lang.Object), cast-from-var3360-to-String=([java.lang.Object], java.lang.String), var391_notEmptyString/1687515918=([java.lang.String, java.lang.String], void), String-init=([], java.lang.StringBuilder), <init>/-1061048412=([java.lang.StringBuilder, java.lang.String], void), var1687_isNotEmpty/-1251449450=([java.lang.String], boolean), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), var2622-init=([], java.util.ArrayList), var2946_keySet/-712633290=([java.util.Map], java.util.Set), <init>/2032108350=([java.util.ArrayList, java.util.Collection], void), cast-from-var2049-to-var2921=([java.util.Set], java.util.Collection), var1848_sort/-787612144=([java.util.List], void), cast-from-var2622-to-var2620=([java.util.ArrayList], java.util.List), var2620_iterator/-912451715=([java.util.List], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), length/-171891354=([java.lang.StringBuilder], int), charAt/1621160911=([java.lang.StringBuilder, int], char), cast-from-Int-to-Int=([char], int), setCharAt/-2056395727=([java.lang.StringBuilder, int, char], void), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2946=java.util.Map, var3781=r0, var804=org.springframework.context.ApplicationContext, var2787=r10, var3360=java.lang.Object, var2136=$r1, var78=r2, var391=org.apache.dubbo.common.utils.Assert, var1710="No interface class or name found from attributes", var3451=$r3, var3509=r4, var3244=$r5, var2664=r6, var450=$r28, var1687=org.apache.dubbo.common.utils.StringUtils, var3328=$z0, var1304=$z1, var2622=java.util.ArrayList, var3274=$r29, var2049=java.util.Set, var972=$r9, var2921=java.util.Collection, var1848=java.util.Collections, var2620=java.util.List, var2520=$r22, var1079=$z3, var3036=$i0, var3942=$i1, var1957=$c2, var2807=$i5, var792=$i3, var3152=$i4, var630=41, var675=$r14, var1734=r26}
; {java.util.Map=var2946, r0=var3781, org.springframework.context.ApplicationContext=var804, r10=var2787, java.lang.Object=var3360, $r1=var2136, r2=var78, org.apache.dubbo.common.utils.Assert=var391, "No interface class or name found from attributes"=var1710, $r3=var3451, r4=var3509, $r5=var3244, r6=var2664, $r28=var450, org.apache.dubbo.common.utils.StringUtils=var1687, $z0=var3328, $z1=var1304, java.util.ArrayList=var2622, $r29=var3274, java.util.Set=var2049, $r9=var972, java.util.Collection=var2921, java.util.Collections=var1848, java.util.List=var2620, $r22=var2520, $z3=var1079, $i0=var3036, $i1=var3942, $c2=var1957, $i5=var2807, $i3=var792, $i4=var3152, 41=var630, $r14=var675, r26=var1734}
;seq <java.lang.StringBuilder: void <init>(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: int length()>;	<java.lang.StringBuilder: char charAt(int)>;	<java.lang.StringBuilder: int length()>;	<java.lang.StringBuilder: void setCharAt(int,char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>(java.lang.String)>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: int length()>": 2,"<java.lang.StringBuilder: char charAt(int)>": 1,"<java.lang.StringBuilder: void setCharAt(int,char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.util.Map;	r10 := @parameter1: org.springframework.context.ApplicationContext;	$r1 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("interface");	r2 = (java.lang.String) $r1;	staticinvoke <org.apache.dubbo.common.utils.Assert: void notEmptyString(java.lang.String,java.lang.String)>(r2, "No interface class or name found from attributes");	$r3 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("group");	r4 = (java.lang.String) $r3;	$r5 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("version");	r6 = (java.lang.String) $r5;	$r28 = new java.lang.StringBuilder;	specialinvoke $r28.<java.lang.StringBuilder: void <init>(java.lang.String)>("ReferenceBean:");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r4);	if $z0 == 0 goto virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r6);	if $z1 == 0 goto virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40);	virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40);	$r29 = new java.util.ArrayList;	$r9 = interfaceinvoke r0.<java.util.Map: java.util.Set keySet()>();	specialinvoke $r29.<java.util.ArrayList: void <init>(java.util.Collection)>($r9);	staticinvoke <java.util.Collections: void sort(java.util.List)>($r29);	$r22 = interfaceinvoke $r29.<java.util.List: java.util.Iterator iterator()>();	$z3 = interfaceinvoke $r22.<java.util.Iterator: boolean hasNext()>();	if $z3 == 0 goto $i0 = virtualinvoke $r28.<java.lang.StringBuilder: int length()>();	$i0 = virtualinvoke $r28.<java.lang.StringBuilder: int length()>();	$i1 = $i0 - 1;	$c2 = virtualinvoke $r28.<java.lang.StringBuilder: char charAt(int)>($i1);	$i5 = (int) $c2;	if $i5 != 44 goto virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41);	$i3 = virtualinvoke $r28.<java.lang.StringBuilder: int length()>();	$i4 = $i3 - 1;	virtualinvoke $r28.<java.lang.StringBuilder: void setCharAt(int,char)>($i4, 41);	goto [?= $r14 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.String toString()>()];	$r14 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.String toString()>();	r26 = $r14;	if r10 == null goto return r26;	return r26
;block_num 8