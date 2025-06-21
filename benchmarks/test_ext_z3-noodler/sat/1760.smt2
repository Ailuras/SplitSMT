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

(declare-sort var2681 0)
(declare-sort var2502 0)
(declare-sort var1222 0)
(declare-sort var1186 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2681_getBoolean/-371725213 (var2681 String var1222) var1222)
(declare-fun var1186-init () var1186)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun append/-1166366385 (String Int) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1658509215 (var1186 String) void)
(declare-const null-var2681 var2681)
(declare-const null-String String)
(declare-const null-var1222 var1222)
(declare-const var1019 var2681) ; Statement: r0 := @this: org.apache.dubbo.common.config.Configuration 
(assert (not (= var1019 null-var2681)))
(declare-const var1922 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1922 null-String)))
(define-const var3264 var1222 (var2681_getBoolean/-371725213 var1019 var1922 null-var1222)) ; Statement: r2 = interfaceinvoke r0.<org.apache.dubbo.common.config.Configuration: java.lang.Boolean getBoolean(java.lang.String,java.lang.Boolean)>(r1, null) 
 ; Statement: if r2 == null goto $r3 = new java.util.NoSuchElementException 
(assert (= var3264 null-var1222)) ; Cond: r2 == null 
(define-const var242 var1186 var1186-init) ; Statement: $r3 = new java.util.NoSuchElementException 
(define-const var3061 String String-init) ; Statement: $r4 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3061)) ; Statement: specialinvoke $r4.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3061!1 String)
(assert (= var3061!1 ""))
(assert true)
(define-const var1569 String (append/-1166366385 var3061!1 39)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39) 
(declare-const var3061!2 String)
(assert (str.prefixof var3061!1 var3061!2))
(assert true)
(define-const var2919 String (append/672562846 var1569 var1922)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var1569!1 String)
(assert (= var1569!1 (str.++ var1569 var1922)))
(assert true)
(define-const var3407 String (append/672562846 var2919 "\u0027 doesn\u0027t map to an existing object")) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\' doesn\'t map to an existing object") 
(declare-const var2919!1 String)
(assert (= var2919!1 (str.++ var2919 "\u0027 doesn\u0027t map to an existing object")))
(assert true)
(define-const var2416 String (toString/-2075883882 var3407)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1658509215 var242 var2416)) ; Statement: specialinvoke $r3.<java.util.NoSuchElementException: void <init>(java.lang.String)>($r8) 

(declare-const var242!1 var1186)
(declare-const var2416!1 String)
 ; Statement: throw $r3 
(check-sat)
; {var2681_getBoolean/-371725213=([org.apache.dubbo.common.config.Configuration, java.lang.String, java.lang.Boolean], java.lang.Boolean), var1186-init=([], java.util.NoSuchElementException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1658509215=([java.util.NoSuchElementException, java.lang.String], void)}
; {var2681=org.apache.dubbo.common.config.Configuration, var1019=r0, var1922=r1, var2502=null_type, var1222=java.lang.Boolean, var3264=r2, var1186=java.util.NoSuchElementException, var242=$r3, var3061=$r4, var1569=$r5, var2919=$r6, var3407=$r7, var2416=$r8}
; {org.apache.dubbo.common.config.Configuration=var2681, r0=var1019, r1=var1922, null_type=var2502, java.lang.Boolean=var1222, r2=var3264, java.util.NoSuchElementException=var1186, $r3=var242, $r4=var3061, $r5=var1569, $r6=var2919, $r7=var3407, $r8=var2416}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.config.Configuration;	r1 := @parameter0: java.lang.String;	r2 = interfaceinvoke r0.<org.apache.dubbo.common.config.Configuration: java.lang.Boolean getBoolean(java.lang.String,java.lang.Boolean)>(r1, null);	if r2 == null goto $r3 = new java.util.NoSuchElementException;	$r3 = new java.util.NoSuchElementException;	$r4 = new java.lang.StringBuilder;	specialinvoke $r4.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\' doesn\'t map to an existing object");	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r3.<java.util.NoSuchElementException: void <init>(java.lang.String)>($r8);	throw $r3
;block_num 2