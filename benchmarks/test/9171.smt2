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

(declare-sort var2915 0)
(declare-sort var2803 0)
(declare-sort var1100 0)
(declare-sort var191 0)
(declare-sort var3666 0)
(declare-sort var1547 0)
(declare-sort var2160 0)
(declare-sort var3141 0)
(declare-sort var1220 0)
(declare-sort var509 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2915_get/1088891777 (var2915 var1100) var1100)
(declare-fun cast-from-String-to-var1100 (String) var1100)
(declare-fun cast-from-var1100-to-String (var1100) String)
(declare-fun var191_notEmptyString/1687515918 (String String) void)
(declare-fun String-init () String)
(define-fun <init>/-1061048412 ((s String)) String s)
(declare-fun var3666_isNotEmpty/-1251449450 (String) Bool)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1166366385 (String Int) String)
(declare-fun var1547-init () var1547)
(declare-fun var2915_keySet/-712633290 (var2915) var2160)
(declare-fun <init>/2032108350 (var1547 var3141) void)
(declare-fun cast-from-var2160-to-var3141 (var2160) var3141)
(declare-fun var1220_sort/-787612144 (var509) void)
(declare-fun cast-from-var1547-to-var509 (var1547) var509)
(declare-fun var509_iterator/-912451715 (var509) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-fun length/-171891354 (String) Int)
(declare-fun charAt/1621160911 (String Int) Int)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2915 var2915)
(declare-const null-var2803 var2803)
(declare-const var558 var2915) ; Statement: r0 := @parameter0: java.util.Map 
(assert (not (= var558 null-var2915)))
(declare-const var1666 var2803) ; Statement: r10 := @parameter1: org.springframework.context.ApplicationContext 
(assert (not (= var1666 null-var2803)))
(define-const var1031 var1100 (var2915_get/1088891777 var558 (cast-from-String-to-var1100 "interface"))) ; Statement: $r1 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("interface") 
(define-const var3748 String (cast-from-var1100-to-String var1031)) ; Statement: r2 = (java.lang.String) $r1 
;(assert (var191_notEmptyString/1687515918 var3748 "No interface class or name found from attributes")) ; Statement: staticinvoke <org.apache.dubbo.common.utils.Assert: void notEmptyString(java.lang.String,java.lang.String)>(r2, "No interface class or name found from attributes") 

(declare-const var3748!1 String)
(declare-const var1330 String)
(define-const var754 var1100 (var2915_get/1088891777 var558 (cast-from-String-to-var1100 "group"))) ; Statement: $r3 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("group") 
(define-const var2754 String (cast-from-var1100-to-String var754)) ; Statement: r4 = (java.lang.String) $r3 
(define-const var3681 var1100 (var2915_get/1088891777 var558 (cast-from-String-to-var1100 "version"))) ; Statement: $r5 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("version") 
(define-const var19 String (cast-from-var1100-to-String var3681)) ; Statement: r6 = (java.lang.String) $r5 
(define-const var1113 String String-init) ; Statement: $r28 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/-1061048412 var1113 "ReferenceBean:")) ; Statement: specialinvoke $r28.<java.lang.StringBuilder: void <init>(java.lang.String)>("ReferenceBean:") 
(declare-const var1113!1 String)
(assert (= var1113!1 "ReferenceBean:"))
(define-const var932 Bool (var3666_isNotEmpty/-1251449450 var2754)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r4) 
 ; Statement: if $z0 == 0 goto virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(assert (= (ite var932 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
;(assert (append/672562846 var1113!1 var3748!1)) ; Statement: virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var1113!2 String)
(assert (= var1113!2 (str.++ var1113!1 var3748!1)))
(define-const var1120 Bool (var3666_isNotEmpty/-1251449450 var19)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r6) 
 ; Statement: if $z1 == 0 goto virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40) 
(assert (= (ite var1120 1 0) 0)) ; Cond: $z1 == 0 
(assert true)
;(assert (append/-1166366385 var1113!2 40)) ; Statement: virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40) 
(declare-const var1113!3 String)
(assert (str.prefixof var1113!2 var1113!3))
(define-const var2453 var1547 var1547-init) ; Statement: $r29 = new java.util.ArrayList 
(define-const var1469 var2160 (var2915_keySet/-712633290 var558)) ; Statement: $r9 = interfaceinvoke r0.<java.util.Map: java.util.Set keySet()>() 
(assert true)
;(assert (<init>/2032108350 var2453 (cast-from-var2160-to-var3141 var1469))) ; Statement: specialinvoke $r29.<java.util.ArrayList: void <init>(java.util.Collection)>($r9) 

(declare-const var2453!1 var1547)
(declare-const var1469!1 var2160)
;(assert (var1220_sort/-787612144 (cast-from-var1547-to-var509 var2453!1))) ; Statement: staticinvoke <java.util.Collections: void sort(java.util.List)>($r29) 

(declare-const var2453!2 var1547)
(define-const var746 Iterator (var509_iterator/-912451715 (cast-from-var1547-to-var509 var2453!2))) ; Statement: $r22 = interfaceinvoke $r29.<java.util.List: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var2704 Bool (Iterator_hasNext/-1669924200 var746)) ; Statement: $z3 = interfaceinvoke $r22.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z3 == 0 goto $i0 = virtualinvoke $r28.<java.lang.StringBuilder: int length()>() 
(assert (= (ite var2704 1 0) 0)) ; Cond: $z3 == 0 
(assert true)
(define-const var2799 Int (length/-171891354 var1113!3)) ; Statement: $i0 = virtualinvoke $r28.<java.lang.StringBuilder: int length()>() 
(define-const var3383 Int (- var2799 1)) ; Statement: $i1 = $i0 - 1 
(assert true)
(define-const var498 Int (charAt/1621160911 var1113!3 var3383)) ; Statement: $c2 = virtualinvoke $r28.<java.lang.StringBuilder: char charAt(int)>($i1) 
(define-const var1869 Int (cast-from-Int-to-Int var498)) ; Statement: $i5 = (int) $c2 
 ; Statement: if $i5 != 44 goto virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41) 
(assert (not (= var1869 44))) ; Cond: $i5 != 44 
(assert true)
;(assert (append/-1166366385 var1113!3 41)) ; Statement: virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41) 
(declare-const var1113!4 String)
(assert (str.prefixof var1113!3 var1113!4))
(assert true) ; Non Conditional
(assert true)
(define-const var3257 String (toString/-2075883882 var1113!4)) ; Statement: $r14 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var2942 String var3257) ; Statement: r26 = $r14 
 ; Statement: if r10 == null goto return r26 
(assert (= var1666 null-var2803)) ; Cond: r10 == null 
 ; Statement: return r26 
(check-sat)
; {var2915_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var1100=([java.lang.String], java.lang.Object), cast-from-var1100-to-String=([java.lang.Object], java.lang.String), var191_notEmptyString/1687515918=([java.lang.String, java.lang.String], void), String-init=([], java.lang.StringBuilder), <init>/-1061048412=([java.lang.StringBuilder, java.lang.String], void), var3666_isNotEmpty/-1251449450=([java.lang.String], boolean), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), var1547-init=([], java.util.ArrayList), var2915_keySet/-712633290=([java.util.Map], java.util.Set), <init>/2032108350=([java.util.ArrayList, java.util.Collection], void), cast-from-var2160-to-var3141=([java.util.Set], java.util.Collection), var1220_sort/-787612144=([java.util.List], void), cast-from-var1547-to-var509=([java.util.ArrayList], java.util.List), var509_iterator/-912451715=([java.util.List], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), length/-171891354=([java.lang.StringBuilder], int), charAt/1621160911=([java.lang.StringBuilder, int], char), cast-from-Int-to-Int=([char], int), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2915=java.util.Map, var558=r0, var2803=org.springframework.context.ApplicationContext, var1666=r10, var1100=java.lang.Object, var1031=$r1, var3748=r2, var191=org.apache.dubbo.common.utils.Assert, var1330="No interface class or name found from attributes", var754=$r3, var2754=r4, var3681=$r5, var19=r6, var1113=$r28, var3666=org.apache.dubbo.common.utils.StringUtils, var932=$z0, var1120=$z1, var1547=java.util.ArrayList, var2453=$r29, var2160=java.util.Set, var1469=$r9, var3141=java.util.Collection, var1220=java.util.Collections, var509=java.util.List, var746=$r22, var2704=$z3, var2799=$i0, var3383=$i1, var498=$c2, var1869=$i5, var3257=$r14, var2942=r26}
; {java.util.Map=var2915, r0=var558, org.springframework.context.ApplicationContext=var2803, r10=var1666, java.lang.Object=var1100, $r1=var1031, r2=var3748, org.apache.dubbo.common.utils.Assert=var191, "No interface class or name found from attributes"=var1330, $r3=var754, r4=var2754, $r5=var3681, r6=var19, $r28=var1113, org.apache.dubbo.common.utils.StringUtils=var3666, $z0=var932, $z1=var1120, java.util.ArrayList=var1547, $r29=var2453, java.util.Set=var2160, $r9=var1469, java.util.Collection=var3141, java.util.Collections=var1220, java.util.List=var509, $r22=var746, $z3=var2704, $i0=var2799, $i1=var3383, $c2=var498, $i5=var1869, $r14=var3257, r26=var2942}
;seq <java.lang.StringBuilder: void <init>(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: int length()>;	<java.lang.StringBuilder: char charAt(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>(java.lang.String)>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 2,"<java.lang.StringBuilder: int length()>": 1,"<java.lang.StringBuilder: char charAt(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.util.Map;	r10 := @parameter1: org.springframework.context.ApplicationContext;	$r1 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("interface");	r2 = (java.lang.String) $r1;	staticinvoke <org.apache.dubbo.common.utils.Assert: void notEmptyString(java.lang.String,java.lang.String)>(r2, "No interface class or name found from attributes");	$r3 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("group");	r4 = (java.lang.String) $r3;	$r5 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("version");	r6 = (java.lang.String) $r5;	$r28 = new java.lang.StringBuilder;	specialinvoke $r28.<java.lang.StringBuilder: void <init>(java.lang.String)>("ReferenceBean:");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r4);	if $z0 == 0 goto virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r6);	if $z1 == 0 goto virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40);	virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40);	$r29 = new java.util.ArrayList;	$r9 = interfaceinvoke r0.<java.util.Map: java.util.Set keySet()>();	specialinvoke $r29.<java.util.ArrayList: void <init>(java.util.Collection)>($r9);	staticinvoke <java.util.Collections: void sort(java.util.List)>($r29);	$r22 = interfaceinvoke $r29.<java.util.List: java.util.Iterator iterator()>();	$z3 = interfaceinvoke $r22.<java.util.Iterator: boolean hasNext()>();	if $z3 == 0 goto $i0 = virtualinvoke $r28.<java.lang.StringBuilder: int length()>();	$i0 = virtualinvoke $r28.<java.lang.StringBuilder: int length()>();	$i1 = $i0 - 1;	$c2 = virtualinvoke $r28.<java.lang.StringBuilder: char charAt(int)>($i1);	$i5 = (int) $c2;	if $i5 != 44 goto virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41);	virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41);	$r14 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.String toString()>();	r26 = $r14;	if r10 == null goto return r26;	return r26
;block_num 8