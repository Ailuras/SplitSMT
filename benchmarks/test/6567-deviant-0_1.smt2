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

(declare-sort var416 0)
(declare-sort var2635 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2635_isBeanPropertyWriteMethod/-1621676998 (var416) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getName/1227988463 (var416) String)
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(define-fun toLowerCase/415700667 ((s String)) String (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all s "A" "a") "B" "b") "C" "c") "D" "d") "E" "e") "F" "f") "G" "g") "H" "h") "I" "i") "J" "j") "K" "k") "L" "l") "M" "m") "N" "n") "O" "o") "P" "p") "Q" "q") "R" "r") "S" "s") "T" "t") "U" "u") "V" "v") "W" "w") "X" "x") "Y" "y") "Z" "z"))
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun substring/850833817 ((s String) (begin Int)) String (str.substr s begin (- (str.len s) begin)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var416 var416)
(declare-const var1724 var416) ; Statement: r0 := @parameter0: java.lang.reflect.Method 
(assert (not (= var1724 null-var416)))
(define-const var506 Bool (var2635_isBeanPropertyWriteMethod/-1621676998 var1724)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: boolean isBeanPropertyWriteMethod(java.lang.reflect.Method)>(r0) 
 ; Statement: if $z0 == 0 goto return null 
(assert (not (= (ite var506 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2570 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2570)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2570!1 String)
(assert (= var2570!1 ""))
(assert true)
(define-const var2226 String (getName/1227988463 var1724)) ; Statement: $r2 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>() 
(assert (not (and true (and (>= 3 0) (>= (str.len var2226) 4) (>= 4 3)))))
(check-sat)
; {var2635_isBeanPropertyWriteMethod/-1621676998=([java.lang.reflect.Method], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getName/1227988463=([java.lang.reflect.Method], java.lang.String), substring/-1240304868=([java.lang.String, int, int], java.lang.String), toLowerCase/415700667=([java.lang.String], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), substring/850833817=([java.lang.String, int], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var416=java.lang.reflect.Method, var1724=r0, var2635=org.apache.dubbo.common.utils.ReflectUtils, var506=$z0, var2570=$r1, var2226=$r2, var3472=$r3, var2191=$r4, var1068=$r7, var1631=$r5, var2263=$r6, var523=$r8, var2100=$r9}
; {java.lang.reflect.Method=var416, r0=var1724, org.apache.dubbo.common.utils.ReflectUtils=var2635, $z0=var506, $r1=var2570, $r2=var2226, $r3=var3472, $r4=var2191, $r7=var1068, $r5=var1631, $r6=var2263, $r8=var523, $r9=var2100}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.String: java.lang.String toLowerCase()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.String: java.lang.String substring(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.String: java.lang.String substring(int,int)>": 1,"<java.lang.String: java.lang.String toLowerCase()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.String: java.lang.String substring(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.reflect.Method;	$z0 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: boolean isBeanPropertyWriteMethod(java.lang.reflect.Method)>(r0);	if $z0 == 0 goto return null;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>();	$r3 = virtualinvoke $r2.<java.lang.String: java.lang.String substring(int,int)>(3, 4);	$r4 = virtualinvoke $r3.<java.lang.String: java.lang.String toLowerCase()>();	$r7 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r5 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>();	$r6 = virtualinvoke $r5.<java.lang.String: java.lang.String substring(int)>(4);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	return $r9
;block_num 2