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

(declare-sort var1344 0)
(declare-sort var1950 0)
(declare-sort var817 0)
(declare-sort var622 0)
(declare-sort var2466 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var1950_get/-1216255739 (var1950 Int) var622)
(declare-fun cast-from-var622-to-var2466 (var622) var2466)
(declare-fun getField/-1781158780 (var2466) String)
(define-fun toString/-2075883882 ((s String)) String s)
(define-fun <init>/-1061048412 ((s String)) String s)
(declare-fun var1950_size/-959786421 (var1950) Int)
(declare-fun append/-1166366385 (String Int) String)
(declare-const null-var1344 var1344)
(declare-const null-var1950 var1950)
(declare-const null-String String)
(declare-const var1688 var1344) ; Statement: r18 := @this: org.apache.dubbo.config.spring.context.properties.DefaultDubboConfigBinder 
(assert (not (= var1688 null-var1344)))
(declare-const var422 var1950) ; Statement: r8 := @parameter0: java.util.List 
(assert (not (= var422 null-var1950)))
(declare-const var88 String) ; Statement: r5 := @parameter1: java.lang.String 
(assert (not (= var88 null-String)))
(declare-const var3716 String) ; Statement: r2 := @parameter2: java.lang.String 
(assert (not (= var3716 null-String)))
(define-const var673 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(define-const var1729 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1729)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1729!1 String)
(assert (= var1729!1 ""))
(assert true)
(define-const var2828 String (append/672562846 var1729!1 "Data bind error, please check config. config: ")) ; Statement: $r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Data bind error, please check config. config: ") 
(declare-const var1729!2 String)
(assert (= var1729!2 (str.++ var1729!1 "Data bind error, please check config. config: ")))
(assert true)
(define-const var1366 String (append/672562846 var2828 var3716)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var2828!1 String)
(assert (= var2828!1 (str.++ var2828 var3716)))
(assert true)
(define-const var465 String (append/672562846 var1366 ", prefix: ")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", prefix: ") 
(declare-const var1366!1 String)
(assert (= var1366!1 (str.++ var1366 ", prefix: ")))
(assert true)
(define-const var317 String (append/672562846 var465 var88)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r5) 
(declare-const var465!1 String)
(assert (= var465!1 (str.++ var465 var88)))
(assert true)
(define-const var3957 String (append/672562846 var317 " , error fields: [")) ; Statement: $r12 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" , error fields: [") 
(declare-const var317!1 String)
(assert (= var317!1 (str.++ var317 " , error fields: [")))
(define-const var2085 var622 (var1950_get/-1216255739 var422 0)) ; Statement: $r9 = interfaceinvoke r8.<java.util.List: java.lang.Object get(int)>(0) 
(define-const var3727 var2466 (cast-from-var622-to-var2466 var2085)) ; Statement: $r10 = (org.springframework.validation.FieldError) $r9 
(assert true)
(define-const var764 String (getField/-1781158780 var3727)) ; Statement: $r11 = virtualinvoke $r10.<org.springframework.validation.FieldError: java.lang.String getField()>() 
(assert true)
(define-const var3638 String (append/672562846 var3957 var764)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r11) 
(declare-const var3957!1 String)
(assert (= var3957!1 (str.++ var3957 var764)))
(assert true)
(define-const var3263 String (toString/-2075883882 var3638)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1061048412 var673 var3263)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>($r14) 
(declare-const var673!1 String)
(assert (= var673!1 var3263))
(define-const var3010 Int (var1950_size/-959786421 var422)) ; Statement: $i0 = interfaceinvoke r8.<java.util.List: int size()>() 
 ; Statement: if $i0 <= 1 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(93) 
(assert (<= var3010 1)) ; Cond: $i0 <= 1 
(assert true)
;(assert (append/-1166366385 var673!1 93)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(93) 
(declare-const var673!2 String)
(assert (str.prefixof var673!1 var673!2))
(assert true)
(define-const var1253 String (toString/-2075883882 var673!2)) ; Statement: $r15 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r15 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var1950_get/-1216255739=([java.util.List, int], java.lang.Object), cast-from-var622-to-var2466=([java.lang.Object], org.springframework.validation.FieldError), getField/-1781158780=([org.springframework.validation.FieldError], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1061048412=([java.lang.StringBuilder, java.lang.String], void), var1950_size/-959786421=([java.util.List], int), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder)}
; {var1344=org.apache.dubbo.config.spring.context.properties.DefaultDubboConfigBinder, var1688=r18, var1950=java.util.List, var422=r8, var88=r5, var817=null_type, var3716=r2, var673=$r0, var1729=$r1, var2828=$r3, var1366=$r4, var465=$r6, var317=$r7, var3957=$r12, var622=java.lang.Object, var2085=$r9, var2466=org.springframework.validation.FieldError, var3727=$r10, var764=$r11, var3638=$r13, var3263=$r14, var3010=$i0, var1253=$r15}
; {org.apache.dubbo.config.spring.context.properties.DefaultDubboConfigBinder=var1344, r18=var1688, java.util.List=var1950, r8=var422, r5=var88, null_type=var817, r2=var3716, $r0=var673, $r1=var1729, $r3=var2828, $r4=var1366, $r6=var465, $r7=var317, $r12=var3957, java.lang.Object=var622, $r9=var2085, org.springframework.validation.FieldError=var2466, $r10=var3727, $r11=var764, $r13=var3638, $r14=var3263, $i0=var3010, $r15=var1253}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: void <init>(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 6,"<java.lang.StringBuilder: java.lang.String toString()>": 2,"<java.lang.StringBuilder: void <init>(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1}
;stmts r18 := @this: org.apache.dubbo.config.spring.context.properties.DefaultDubboConfigBinder;	r8 := @parameter0: java.util.List;	r5 := @parameter1: java.lang.String;	r2 := @parameter2: java.lang.String;	$r0 = new java.lang.StringBuilder;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Data bind error, please check config. config: ");	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", prefix: ");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r5);	$r12 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" , error fields: [");	$r9 = interfaceinvoke r8.<java.util.List: java.lang.Object get(int)>(0);	$r10 = (org.springframework.validation.FieldError) $r9;	$r11 = virtualinvoke $r10.<org.springframework.validation.FieldError: java.lang.String getField()>();	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r11);	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>($r14);	$i0 = interfaceinvoke r8.<java.util.List: int size()>();	if $i0 <= 1 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(93);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(93);	$r15 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r15
;block_num 2