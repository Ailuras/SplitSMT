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

(declare-sort var3911 0)
(declare-sort var3945 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(define-fun toLowerCase/415700667 ((s String)) String (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all s "A" "a") "B" "b") "C" "c") "D" "d") "E" "e") "F" "f") "G" "g") "H" "h") "I" "i") "J" "j") "K" "k") "L" "l") "M" "m") "N" "n") "O" "o") "P" "p") "Q" "q") "R" "r") "S" "s") "T" "t") "U" "u") "V" "v") "W" "w") "X" "x") "Y" "y") "Z" "z"))
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun substring/850833817 ((s String) (begin Int)) String (str.substr s begin (- (str.len s) begin)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3945_camelToSplitName/-763255368 (String String) String)
(declare-const null-String String)
(declare-const var1936 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1936 null-String)))
(assert true)
(define-const var975 Bool (startsWith/-1785782452 var1936 "get")) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("get") 
 ; Statement: if $z0 == 0 goto $b5 = 2 
(assert (not (= (ite var975 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var164 Int 3) ; Statement: $b5 = 3 
(define-const var2 Int 3) ; Statement: $b4 = 3 
(define-const var2113 Int 3) ; Statement: $b3 = 3 
 ; Statement: goto [?= $r1 = new java.lang.StringBuilder] 
(assert true) ; Non Conditional
(define-const var1163 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1163)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1163!1 String)
(assert (= var1163!1 ""))
(define-const var304 Int (+ var2113 1)) ; Statement: $i0 = $b3 + 1 
(assert (and true (and (>= var2 0) (>= (str.len var1936) var304) (>= var304 var2))))
(define-const var1608 String (substring/-1240304868 var1936 var2 var304)) ; Statement: $r2 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>($b4, $i0) 
(assert true)
(define-const var1535 String (toLowerCase/415700667 var1608)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.String: java.lang.String toLowerCase()>() 
(assert true)
(define-const var1097 String (append/672562846 var1163!1 var1535)) ; Statement: $r5 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var1163!2 String)
(assert (= var1163!2 (str.++ var1163!1 var1535)))
(define-const var3300 Int (+ var164 1)) ; Statement: $i1 = $b5 + 1 
(assert (not (and true (and (>= var3300 0) (>= (str.len var1936) var3300)))))
(check-sat)
; {startsWith/-1785782452=([java.lang.String, java.lang.String], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), substring/-1240304868=([java.lang.String, int, int], java.lang.String), toLowerCase/415700667=([java.lang.String], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), substring/850833817=([java.lang.String, int], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3945_camelToSplitName/-763255368=([java.lang.String, java.lang.String], java.lang.String)}
; {var1936=r0, var3911=null_type, var975=$z0, var164=$b5, var2=$b4, var2113=$b3, var1163=$r1, var304=$i0, var1608=$r2, var1535=$r3, var1097=$r5, var3300=$i1, var2812=$r4, var3846=$r6, var1410=$r7, var3945=org.apache.dubbo.common.utils.StringUtils, var2029=$r8}
; {r0=var1936, null_type=var3911, $z0=var975, $b5=var164, $b4=var2, $b3=var2113, $r1=var1163, $i0=var304, $r2=var1608, $r3=var1535, $r5=var1097, $i1=var3300, $r4=var2812, $r6=var3846, $r7=var1410, org.apache.dubbo.common.utils.StringUtils=var3945, $r8=var2029}
;seq <java.lang.String: boolean startsWith(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.String: java.lang.String toLowerCase()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.String: java.lang.String substring(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<org.apache.dubbo.common.utils.StringUtils: java.lang.String camelToSplitName(java.lang.String,java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.String: java.lang.String substring(int,int)>": 1,"<java.lang.String: java.lang.String toLowerCase()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.String: java.lang.String substring(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1,"<org.apache.dubbo.common.utils.StringUtils: java.lang.String camelToSplitName(java.lang.String,java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("get");	if $z0 == 0 goto $b5 = 2;	$b5 = 3;	$b4 = 3;	$b3 = 3;	goto [?= $r1 = new java.lang.StringBuilder];	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$i0 = $b3 + 1;	$r2 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>($b4, $i0);	$r3 = virtualinvoke $r2.<java.lang.String: java.lang.String toLowerCase()>();	$r5 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$i1 = $b5 + 1;	$r4 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int)>($i1);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	$r8 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String camelToSplitName(java.lang.String,java.lang.String)>($r7, ".");	return $r8
;block_num 3