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

(declare-sort var2745 0)
(declare-sort var3983 0)
(declare-sort var2423 0)
(declare-sort var3340 0)
(declare-sort var3433 0)
(declare-sort var986 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(define-fun toUpperCase/1156088314 ((s String)) String (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all s "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z"))
(define-fun substring/850833817 ((s String) (begin Int)) String (str.substr s begin (- (str.len s) begin)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun var3433_get/1088891777 (var3433 var3340) var3340)
(declare-fun cast-from-var3983-to-var3433 (var3983) var3433)
(declare-fun cast-from-String-to-var3340 (String) var3340)
(declare-fun cast-from-var3340-to-var986 (var3340) var986)
(declare-const null-ClassObject ClassObject)
(declare-const null-String String)
(declare-const var2423-NAME_METHODS_CACHE var3983)
(declare-const null-var986 var986)
(declare-const var2123 ClassObject) ; Statement: r11 := @parameter0: java.lang.Class 
(assert (not (= var2123 null-ClassObject)))
(declare-const var437 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var437 null-String)))
(declare-const var1021 ClassObject) ; Statement: r16 := @parameter2: java.lang.Class 
(assert (not (= var1021 null-ClassObject)))
(define-const var820 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var820)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var820!1 String)
(assert (= var820!1 ""))
(assert true)
(define-const var3490 String (append/672562846 var820!1 "set")) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("set") 
(declare-const var820!2 String)
(assert (= var820!2 (str.++ var820!1 "set")))
(assert (and true (and (>= 0 0) (>= (str.len var437) 1) (>= 1 0))))
(define-const var1693 String (substring/-1240304868 var437 0 1)) ; Statement: $r2 = virtualinvoke r1.<java.lang.String: java.lang.String substring(int,int)>(0, 1) 
(assert true)
(define-const var2973 String (toUpperCase/1156088314 var1693)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.String: java.lang.String toUpperCase()>() 
(assert true)
(define-const var1676 String (append/672562846 var3490 var2973)) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var3490!1 String)
(assert (= var3490!1 (str.++ var3490 var2973)))
(assert (not (and true (and (>= 1 0) (>= (str.len var437) 1)))))
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), substring/-1240304868=([java.lang.String, int, int], java.lang.String), toUpperCase/1156088314=([java.lang.String], java.lang.String), substring/850833817=([java.lang.String, int], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), getName/-1958580599=([java.lang.Class], java.lang.String), var3433_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-var3983-to-var3433=([java.util.concurrent.ConcurrentMap], java.util.Map), cast-from-String-to-var3340=([java.lang.String], java.lang.Object), cast-from-var3340-to-var986=([java.lang.Object], java.lang.reflect.Method)}
; {var2123=r11, var437=r1, var2745=null_type, var1021=r16, var820=$r0, var3490=$r4, var1693=$r2, var2973=$r3, var1676=$r6, var3286=$r5, var3767=$r7, var3496=r8, var3983=java.util.concurrent.ConcurrentMap, var2423=org.apache.dubbo.common.utils.PojoUtils, var1952=$r10, var2730=$r9, var170=$r12, var2761=$r13, var526=$r14, var3459=$r15, var1565=$r18, var212=$r17, var1816=$r19, var362=$r20, var2435=$r21, var3340=java.lang.Object, var3433=java.util.Map, var1790=$r22, var986=java.lang.reflect.Method, var1812=r39}
; {r11=var2123, r1=var437, null_type=var2745, r16=var1021, $r0=var820, $r4=var3490, $r2=var1693, $r3=var2973, $r6=var1676, $r5=var3286, $r7=var3767, r8=var3496, java.util.concurrent.ConcurrentMap=var3983, org.apache.dubbo.common.utils.PojoUtils=var2423, $r10=var1952, $r9=var2730, $r12=var170, $r13=var2761, $r14=var526, $r15=var3459, $r18=var1565, $r17=var212, $r19=var1816, $r20=var362, $r21=var2435, java.lang.Object=var3340, java.util.Map=var3433, $r22=var1790, java.lang.reflect.Method=var986, r39=var1812}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.String: java.lang.String toUpperCase()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.String: java.lang.String substring(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 9,"<java.lang.String: java.lang.String substring(int,int)>": 1,"<java.lang.String: java.lang.String toUpperCase()>": 1,"<java.lang.String: java.lang.String substring(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 2}
;stmts r11 := @parameter0: java.lang.Class;	r1 := @parameter1: java.lang.String;	r16 := @parameter2: java.lang.Class;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("set");	$r2 = virtualinvoke r1.<java.lang.String: java.lang.String substring(int,int)>(0, 1);	$r3 = virtualinvoke $r2.<java.lang.String: java.lang.String toUpperCase()>();	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r5 = virtualinvoke r1.<java.lang.String: java.lang.String substring(int)>(1);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	$r10 = <org.apache.dubbo.common.utils.PojoUtils: java.util.concurrent.ConcurrentMap NAME_METHODS_CACHE>;	$r9 = new java.lang.StringBuilder;	specialinvoke $r9.<java.lang.StringBuilder: void <init>()>();	$r12 = virtualinvoke r11.<java.lang.Class: java.lang.String getName()>();	$r13 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12);	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".");	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r8);	$r18 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(");	$r17 = virtualinvoke r16.<java.lang.Class: java.lang.String getName()>();	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r17);	$r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(")");	$r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.String toString()>();	$r22 = interfaceinvoke $r10.<java.util.concurrent.ConcurrentMap: java.lang.Object get(java.lang.Object)>($r21);	r39 = (java.lang.reflect.Method) $r22;	if r39 != null goto return r39;	return r39
;block_num 2