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

(declare-sort var1681 0)
(declare-sort var731 0)
(declare-sort var3044 0)
(declare-sort var2531 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(define-fun toUpperCase/1156088314 ((s String)) String (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all s "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z"))
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun substring/850833817 ((s String) (begin Int)) String (str.substr s begin (- (str.len s) begin)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1681 var1681)
(declare-const null-ClassObject ClassObject)
(declare-const null-String String)
(declare-const null-var3044 var3044)
(declare-const null-var2531 var2531)
(declare-const var1996 var1681) ; Statement: r22 := @this: org.apache.dubbo.config.AbstractConfig 
(assert (not (= var1996 null-var1681)))
(declare-const var816 ClassObject) ; Statement: r8 := @parameter0: java.lang.Class 
(assert (not (= var816 null-ClassObject)))
(declare-const var1713 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var1713 null-String)))
(define-const var3204 var3044 null-var3044) ; Statement: r23 = null 
(define-const var2378 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2378)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2378!1 String)
(assert (= var2378!1 ""))
(assert (and true (and (>= 0 0) (>= (str.len var1713) 1) (>= 1 0))))
(define-const var777 String (substring/-1240304868 var1713 0 1)) ; Statement: $r2 = virtualinvoke r1.<java.lang.String: java.lang.String substring(int,int)>(0, 1) 
(assert true)
(define-const var26 String (toUpperCase/1156088314 var777)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.String: java.lang.String toUpperCase()>() 
(assert true)
(define-const var2294 String (append/672562846 var2378!1 var26)) ; Statement: $r5 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var2378!2 String)
(assert (= var2378!2 (str.++ var2378!1 var26)))
(assert (and true (and (>= 1 0) (>= (str.len var1713) 1))))
(define-const var3978 String (substring/850833817 var1713 1)) ; Statement: $r4 = virtualinvoke r1.<java.lang.String: java.lang.String substring(int)>(1) 
(assert true)
(define-const var3129 String (append/672562846 var2294 var3978)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var2294!1 String)
(assert (= var2294!1 (str.++ var2294 var3978)))
(assert true)
(define-const var2317 String (toString/-2075883882 var3129)) ; Statement: r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var1015 String String-init) ; Statement: $r9 = new java.lang.StringBuilder 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3491 var2531) ; Statement: $r16 := @caughtexception 
(assert (not (= var3491 null-var2531)))
(define-const var3074 String String-init) ; Statement: $r17 = new java.lang.StringBuilder 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2820 var2531) ; Statement: $r15 := @caughtexception 
(assert (not (= var2820 null-var2531)))
(assert true) ; Non Conditional
 ; Statement: if r23 != null goto $r14 = virtualinvoke r23.<java.lang.reflect.Method: java.lang.'annotation'.Annotation getAnnotation(java.lang.Class)>(class "Lorg/apache/dubbo/config/support/Parameter;") 
(assert (not (not (= var3204 null-var3044)))) ; Negate: Cond: r23 != null  
 ; Statement: return 1 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), substring/-1240304868=([java.lang.String, int, int], java.lang.String), toUpperCase/1156088314=([java.lang.String], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), substring/850833817=([java.lang.String, int], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1681=org.apache.dubbo.config.AbstractConfig, var1996=r22, var816=r8, var1713=r1, var731=null_type, var3044=java.lang.reflect.Method, var3204=r23, var2378=$r0, var777=$r2, var26=$r3, var2294=$r5, var3978=$r4, var3129=$r6, var2317=r7, var1015=$r9, var2531=java.lang.NoSuchMethodException, var3491=$r16, var3074=$r17, var2820=$r15}
; {org.apache.dubbo.config.AbstractConfig=var1681, r22=var1996, r8=var816, r1=var1713, null_type=var731, java.lang.reflect.Method=var3044, r23=var3204, $r0=var2378, $r2=var777, $r3=var26, $r5=var2294, $r4=var3978, $r6=var3129, r7=var2317, $r9=var1015, java.lang.NoSuchMethodException=var2531, $r16=var3491, $r17=var3074, $r15=var2820}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.String: java.lang.String toUpperCase()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.String: java.lang.String substring(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.String: java.lang.String substring(int,int)>": 1,"<java.lang.String: java.lang.String toUpperCase()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.String: java.lang.String substring(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r22 := @this: org.apache.dubbo.config.AbstractConfig;	r8 := @parameter0: java.lang.Class;	r1 := @parameter1: java.lang.String;	r23 = null;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<java.lang.String: java.lang.String substring(int,int)>(0, 1);	$r3 = virtualinvoke $r2.<java.lang.String: java.lang.String toUpperCase()>();	$r5 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r4 = virtualinvoke r1.<java.lang.String: java.lang.String substring(int)>(1);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	$r9 = new java.lang.StringBuilder;	$r16 := @caughtexception;	$r17 = new java.lang.StringBuilder;	$r15 := @caughtexception;	if r23 != null goto $r14 = virtualinvoke r23.<java.lang.reflect.Method: java.lang.'annotation'.Annotation getAnnotation(java.lang.Class)>(class "Lorg/apache/dubbo/config/support/Parameter;");	return 1
;block_num 5